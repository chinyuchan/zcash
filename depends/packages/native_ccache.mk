package=native_ccache
$(package)_version=4.10.1
$(package)_download_path=https://github.com/ccache/ccache/releases/download/v$($(package)_version)
$(package)_file_name=ccache-$($(package)_version).tar.gz
$(package)_sha256_hash=8f8ad60d9363857812aa8af3fa7fb72be5ea5cf193f824d16d237a8a79256be4
$(package)_build_subdir=build
$(package)_dependencies=native_cmake native_fmt native_xxhash native_zstd

define $(package)_set_vars
$(package)_config_opts += -DCMAKE_BUILD_TYPE=Release
$(package)_config_opts += -DDEPS=LOCAL
$(package)_config_opts += -DCMAKE_PREFIX_PATH=$(build_prefix)
$(package)_config_opts += -DFMT_LIBRARY=$(build_prefix)/lib/libfmt.a
$(package)_config_opts += -DXXHASH_LIBRARY=$(build_prefix)/lib/libxxhash.a
$(package)_config_opts += -DZSTD_LIBRARY=$(build_prefix)/lib/libzstd.a
$(package)_config_opts += -DREDIS_STORAGE_BACKEND=OFF
$(package)_config_opts += -DENABLE_TESTING=OFF
endef

define $(package)_preprocess_cmds
  mkdir $($(package)_build_subdir)
endef

define $(package)_config_cmds
  $($(package)_cmake) .. $($(package)_config_opts)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

define $(package)_postprocess_cmds
  rm -rf lib include
endef
