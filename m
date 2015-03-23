From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Mar 2015 19:18:16 +0000 (UTC)
Subject: [PATCH] NVMe: Persistent Reservation NVMe translations
In-Reply-To: <1427133430-1208-1-git-send-email-keith.busch@intel.com>
References: <1427133430-1208-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1503231915450.32385@localhost.lm.intel.com>

On Mon, 23 Mar 2015, Keith Busch wrote:
> +	for (i = 0; i < regctl; i++) {
> +		keys->keys[i] = cpu_to_be64(le32_to_cpu(
> +					resv_status->regctl_ds[i].rkey));
> +	}

Sparse failed me! Should be le64_to_cpu, not 32. Pretty sure that's the
only type size bug. I'll let this sit for a few days before spinning a v2.
