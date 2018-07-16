From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 16 Jul 2018 17:02:16 +0800
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180713205609.19701-4-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
Message-ID: <c36aad44-0c20-30cc-5b20-5cf82bbeeda2@oracle.com>

Hi Keith

On 07/14/2018 04:56 AM, Keith Busch wrote:
> @@ -134,6 +134,7 @@ enum nvme_ctrl_state {
>  	NVME_CTRL_CONNECTING,
>  	NVME_CTRL_DELETING,
>  	NVME_CTRL_DEAD,
> +	NVME_CTRL_FROZEN,
>  };

We also need to add a state name entry into the nvme_sysfs_show_state

Thanks
Jianchao
