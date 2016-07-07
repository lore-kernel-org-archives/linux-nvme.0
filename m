From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 7 Jul 2016 08:35:17 -0600
Subject: [PATCH] nvme-loop: add configfs dependency
In-Reply-To: <20160707090144.3061799-1-arnd@arndb.de>
References: <20160707090144.3061799-1-arnd@arndb.de>
Message-ID: <577E68A5.8080709@kernel.dk>

On 07/07/2016 03:01 AM, Arnd Bergmann wrote:
> CONFIG_NVME_TARGET has a correct CONFIG_CONFIGFS_FS dependency, but the
> newly added NVME_TARGET_LOOP is missing this, resulting in a link
> failure:
>
> drivers/nvme/built-in.o: In function `nvmet_init_configfs':
> loop.c:(.init.text+0x2a0): undefined reference to `config_group_init'
> loop.c:(.init.text+0x2c0): undefined reference to `config_group_init_type_name'
> loop.c:(.init.text+0x318): undefined reference to `configfs_register_subsystem'
> drivers/nvme/built-in.o: In function `nvmet_exit_configfs':
> loop.c:(.exit.text+0x9c): undefined reference to `configfs_unregister_subsystem'
>
> This adds the same dependency here.

Thanks Arnd, applied.

-- 
Jens Axboe
