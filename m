From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:14:21 +0200
Subject: [PATCH v1 3/3] nvmet: Add port transport state flag
In-Reply-To: <20180412080656.1691-4-sagi@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
 <20180412080656.1691-4-sagi@grimberg.me>
Message-ID: <20180413171421.GA23432@lst.de>

> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +
> +	return sprintf(page, "%s\n",
> +		nvmet_is_port_active(port) ? "up" : "down");
> +}
> +
> +CONFIGFS_ATTR_RO(nvmet_, trstate);
> +
>  /*
>   * Namespace structures & file operation functions below
>   */
> @@ -870,6 +880,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>  	&nvmet_attr_addr_traddr,
>  	&nvmet_attr_addr_trsvcid,
>  	&nvmet_attr_addr_trtype,
> +	&nvmet_attr_trstate,

Please don't create attributes without a group ever.  Just create a
different group which isn't serialized, e.g. state as the group name
and then transport as the attribute name inside it, or something similar.
