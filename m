From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 2 Jun 2017 16:46:40 +0300
Subject: [PATCH v3 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170602094536.25775-4-jthumshirn@suse.de>
References: <20170602094536.25775-1-jthumshirn@suse.de>
 <20170602094536.25775-4-jthumshirn@suse.de>
Message-ID: <4f03d4c0-6f7b-dbc4-b0ee-bebe77e80ea6@grimberg.me>


>  	switch (type) {
>  	case NVME_NQN_NVME:
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index cfc5c7fb0ab7..4c6cb5ea1186 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -46,6 +46,7 @@ struct nvmet_ns {
>  	u32			blksize_shift;
>  	loff_t			size;
>  	u8			nguid[16];
> +	uuid_be			uuid;

This should be uuid_le to match the rest of NVMe.

Also, it would be useful to generate a random default with uuid_le_gen()
for a better out-of-the-box experience.
