From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Aug 2018 14:20:08 -0700
Subject: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
In-Reply-To: <20180815225157.89523-1-wnukowski@google.com>
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
 <20180815225157.89523-1-wnukowski@google.com>
Message-ID: <f4bfde7e-96e5-0751-2248-78b5912aa03b@grimberg.me>


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 17a0190bd88f..4452f8553301 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -306,6 +306,14 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>   		old_value = *dbbuf_db;
>   		*dbbuf_db = value;
>   
> +		/*
> +		 * Ensure that the doorbell is updated before reading
> +		 * the EventIdx from memory. NVMe controller should have
> +		 * similar ordering guarantees - update EventIdx before
> +		 * reading doorbell.
> +		 */
> +		mb();
> +
>   		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
>   			return false;
>   	}

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
