From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 Nov 2016 18:11:12 +0100
Subject: [PATCH nvme-cli v1 1/2] nvme-cli: Add nvme hostnqn generation
 option
In-Reply-To: <1478602108-29571-2-git-send-email-sagi@grimberg.me>
References: <1478602108-29571-1-git-send-email-sagi@grimberg.me>
 <1478602108-29571-2-git-send-email-sagi@grimberg.me>
Message-ID: <20161116171112.GC5005@lst.de>

On Tue, Nov 08, 2016@12:48:27PM +0200, Sagi Grimberg wrote:
> Add option to generate a NVMe qualified name of a given host
> (in the form of: nqn.2014-08.org.nvmexpress:NVMf:uuid:<some_uuid>).
> This hostnqn will be used for fabrics discovery and connect functions.

Keith - should we have any special prefixes for nvme-cli commands
that don't map to NVMe commands? 

> +static int gen_hostnqn_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
> +{
> +	char hostnqn[NVMF_NQN_SIZE];
> +	uuid_t uuid;
> +	char uuid_str[37]; /* e.g. 1b4e28ba-2fa1-11d2-883f-0016d3cca427 + \0 */
> +
> +	uuid_generate_random(uuid);
> +	uuid_unparse_lower(uuid, uuid_str);
> +	sprintf(hostnqn, "nqn.2014-08.org.nvmexpress:NVMf:uuid:%s", uuid_str);
> +	printf("%s\n", hostnqn);

Shouldn't the sprintf and printf get merged into one?  No need for the
local variable here.  That would also take care of the snprintf nitpick
from Jay ;-)
