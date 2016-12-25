From: kernel@jbeekman.nl (Jethro Beekman)
Date: Sun, 25 Dec 2016 15:15:53 +0100
Subject: [PATCH v3 1/5] include: Add definitions for sed
In-Reply-To: <1482176149-2257-2-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-2-git-send-email-scott.bauer@intel.com>
Message-ID: <26b9c96f-99ae-6669-5cbe-bff563e20255@jbeekman.nl>

On 19-12-16 20:35, Scott Bauer wrote:
> diff --git a/include/linux/sed.h b/include/linux/sed.h
>
> +/*
> + * These constant values come from:
> + * TCG Storage Architecture Core Spec v2.01 r1
> + * Section: 3.3 Interface Communications
> + */
> +enum {
> +	TCG_SECP_00 = 0,

Protocol 0 is not defined by TCG. Perhaps you should reference SPC-4 section
6.30 SECURITY PROTOCOL IN command / table 265.

> diff --git a/include/uapi/linux/sed.h b/include/uapi/linux/sed.h
>
> +enum sed_key_type {
> +	OPAL,
> +	OPAL_PW,
> +	OPAL_ACT_USR,
> +	OPAL_LR_SETUP,
> +	OPAL_LOCK_UNLOCK,
> +	OPAL_MBR_DATA,
> +};
> +
> +struct sed_key {
> +	__u32 sed_type;
> +	union {
> +		struct opal_key            opal;
> +		struct opal_new_pw         opal_pw;
> +		struct opal_session_info   opal_session;
> +		struct opal_user_lr_setup  opal_lrs;
> +		struct opal_lock_unlock    opal_lk_unlk;
> +		struct opal_mbr_data       opal_mbr;
> +		/* additional command set key types */
> +	};
> +};
> +
> +#define IOC_SED_SAVE		   _IOW('p', 220, struct sed_key)
> +#define IOC_SED_LOCK_UNLOCK	   _IOW('p', 221, struct sed_key)
> +#define IOC_SED_TAKE_OWNERSHIP	   _IOW('p', 222, struct sed_key)
> +#define IOC_SED_ACTIVATE_LSP       _IOW('p', 223, struct sed_key)
> +#define IOC_SED_SET_PW             _IOW('p', 224, struct sed_key)
> +#define IOC_SED_ACTIVATE_USR       _IOW('p', 225, struct sed_key)
> +#define IOC_SED_REVERT_TPR         _IOW('p', 226, struct sed_key)
> +#define IOC_SED_LR_SETUP           _IOW('p', 227, struct sed_key)
> +#define IOC_SED_ADD_USR_TO_LR      _IOW('p', 228, struct sed_key)
> +#define IOC_SED_ENABLE_DISABLE_MBR _IOW('p', 229, struct sed_key)
> +#define IOC_SED_ERASE_LR           _IOW('p', 230, struct sed_key)
> +#define IOC_SED_SECURE_ERASE_LR    _IOW('p', 231, struct sed_key)

I'm slightly confused by the split between SED-generic and OPAL-specific files
here. Maybe I'm misunderstanding the intent of these ioctls. I think SED means
"possible any drive supporting the security command set". Therefore these
definitions (quoted) should have OPAL names and live in an OPAL header.

Jethro
