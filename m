From: james.smart@broadcom.com (James Smart)
Date: Mon, 17 Apr 2017 15:29:22 -0700
Subject: [PATCH 2/3] nvme-fabrics: Allow ctrl loss timeout configuration
In-Reply-To: <1489876941-6401-3-git-send-email-sagi@grimberg.me>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
 <1489876941-6401-3-git-send-email-sagi@grimberg.me>
Message-ID: <1c260723-1771-3518-87b1-60d95fa423d8@broadcom.com>

On 3/18/2017 3:42 PM, Sagi Grimberg wrote:
> + * @nr_reconnects: number of reconnect attempted since the last ctrl failure
> + * @max_reconnects: maximum number of allowed reconnect attempts before removing
> + *              the controller, (-1) means reconnect forever, zero means remove
> + *              immediately;
>    */
>   struct nvmf_ctrl_options {
>   	unsigned		mask;
> @@ -91,6 +98,8 @@ struct nvmf_ctrl_options {
>   	bool			discovery_nqn;
>   	unsigned int		kato;
>   	struct nvmf_host	*host;
> +	int			nr_reconnects;
> +	int			max_reconnects;
>   };
>   
>   /*
> @@ -133,5 +142,6 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
>   void nvmf_free_options(struct nvmf_ctrl_options *opts);
>   const char *nvmf_get_subsysnqn(struct nvme_ctrl *ctrl);
>   int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
> +bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);

I know this patch has been pulled in - but I think it very odd that we 
added a field (nr_reconnects) into the opts structure, that is not an 
connect option but is instead a dynamically-changing transport 
variable.  As the change introduced a common transport variable beyond 
start options, the patch should have formally added a generic transport 
structure to the ctrl structure.

-- james
