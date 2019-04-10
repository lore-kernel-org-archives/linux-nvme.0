From: james.smart@broadcom.com (James Smart)
Date: Wed, 10 Apr 2019 14:53:10 -0700
Subject: [PATCH] nvme,scsi: display FC-NVMe port roles
In-Reply-To: <20190410141619.146391-1-hare@suse.de>
References: <20190410141619.146391-1-hare@suse.de>
Message-ID: <b9fc7ec3-bb51-3ec1-9203-5a1d93e4ff31@broadcom.com>



On 4/10/2019 7:16 AM, Hannes Reinecke wrote:
> Currently the FC-NVMe driver is leverating the SCSI FC transport
> class to access the remote ports. Which means that all FC-NVMe
> remote ports will be visible to the fc transport layer, but due
> to missing definitions the port roles will always be 'unknown'.
> This patch adds the missing definitions to the fc transport class
> to that the port roles are correctly displayed.

Well, I don't agree with all of the statements, but do agree, if they 
are there it's rather unclear what the heck they are. And this would be 
a help.

>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/fc.c           |  2 +-
>   drivers/scsi/lpfc/lpfc_hbadisc.c | 10 ++++++++--
>   drivers/scsi/qla2xxx/qla_def.h   |  5 ++++-
>   drivers/scsi/qla2xxx/qla_init.c  | 15 +++++++++++----
>   drivers/scsi/qla2xxx/qla_mbx.c   |  8 +++++++-
>   drivers/scsi/scsi_transport_fc.c |  3 +++
>   include/linux/nvme-fc-driver.h   |  6 ------
>   include/scsi/scsi_transport_fc.h |  3 +++
>   8 files changed, 37 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index f3b9d91ba0df..31637f8ef22e 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -14,7 +14,7 @@
>   #include "fabrics.h"
>   #include <linux/nvme-fc-driver.h>
>   #include <linux/nvme-fc.h>
> -
> +#include <scsi/scsi_transport_fc.h>

I really don't like this cross-pollination, but it works.

>   
>   /* *************************** Data Structures/Defines ****************** */
>   
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index aa4961a2caf8..30d393dddb3b 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -4147,9 +4147,15 @@ lpfc_register_remote_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
>   	rdata->pnode = lpfc_nlp_get(ndlp);
>   
>   	if (ndlp->nlp_type & NLP_FCP_TARGET)
> -		rport_ids.roles |= FC_RPORT_ROLE_FCP_TARGET;
> +		rport_ids.roles |= FC_PORT_ROLE_FCP_TARGET;
>   	if (ndlp->nlp_type & NLP_FCP_INITIATOR)
> -		rport_ids.roles |= FC_RPORT_ROLE_FCP_INITIATOR;
> +		rport_ids.roles |= FC_PORT_ROLE_FCP_INITIATOR;

A little cleanup to move to the FC_PORT_ROLE_xxx defines is ok.

> +	if (ndlp->nlp_type & NLP_NVME_INITIATOR)
> +		rport_ids.roles |= FC_PORT_ROLE_NVME_INITIATOR;
> +	if (ndlp->nlp_type & NLP_NVME_TARGET)
> +		rport_ids.roles |= FC_PORT_ROLE_NVME_TARGET;
> +	if (ndlp->nlp_type & NLP_NVME_DISCOVERY)
> +		rport_ids.roles |= FC_PORT_ROLE_NVME_DISCOVERY;
>   
>   	if (rport_ids.roles !=  FC_RPORT_ROLE_UNKNOWN)
>   		fc_remote_port_rolechg(rport, rport_ids.roles);
> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
> index 3d46975a5e5c..7342ac77149e 100644
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
> @@ -2258,7 +2258,10 @@ typedef enum {
>   	FCT_BROADCAST,
>   	FCT_INITIATOR,
>   	FCT_TARGET,
> -	FCT_NVME
> +	FCT_NVME_INITIATOR = 0x10,
> +	FCT_NVME_TARGET = 0x20,
> +	FCT_NVME_DISCOVERY = 0x40,
> +	FCT_NVME = 0xf0,
>   } fc_port_type_t;
>   
>   enum qla_sess_deletion {
> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
> index 0c700b140ce7..8e254dfeed89 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -5194,16 +5194,23 @@ qla2x00_reg_remote_port(scsi_qla_host_t *vha, fc_port_t *fcport)
>   
>   	rport->supported_classes = fcport->supported_classes;
>   
> -	rport_ids.roles = FC_RPORT_ROLE_UNKNOWN;
> +	rport_ids.roles = FC_PORT_ROLE_UNKNOWN;
>   	if (fcport->port_type == FCT_INITIATOR)
> -		rport_ids.roles |= FC_RPORT_ROLE_FCP_INITIATOR;
> +		rport_ids.roles |= FC_PORT_ROLE_FCP_INITIATOR;
>   	if (fcport->port_type == FCT_TARGET)
> -		rport_ids.roles |= FC_RPORT_ROLE_FCP_TARGET;
> +		rport_ids.roles |= FC_PORT_ROLE_FCP_TARGET;
> +	if (fcport->port_type & FCT_NVME_INITIATOR)
> +		rport_ids.roles |= FC_PORT_ROLE_NVME_INITIATOR;
> +	if (fcport->port_type & FCT_NVME_TARGET)
> +		rport_ids.roles |= FC_PORT_ROLE_NVME_TARGET;
> +	if (fcport->port_type & FCT_NVME_DISCOVERY)
> +		rport_ids.roles |= FC_PORT_ROLE_NVME_DISCOVERY;
>   
>   	ql_dbg(ql_dbg_disc, vha, 0x20ee,
>   	    "%s %8phN. rport %p is %s mode\n",
>   	    __func__, fcport->port_name, rport,
> -	    (fcport->port_type == FCT_TARGET) ? "tgt" : "ini");
> +	    (fcport->port_type == FCT_TARGET) ? "tgt" :
> +	    ((fcport->port_type & FCT_NVME) ? "nvme" :"ini"));
>   
>   	fc_remote_port_rolechg(rport, rport_ids.roles);
>   }
> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
> index 5400696e1f6b..f7203a974fb6 100644
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c
> @@ -6318,7 +6318,13 @@ int __qla24xx_parse_gpdb(struct scsi_qla_host *vha, fc_port_t *fcport,
>   	fcport->d_id.b.rsvd_1 = 0;
>   
>   	if (fcport->fc4f_nvme) {
> -		fcport->port_type = FCT_NVME;
> +		fcport->port_type = 0;
> +		if ((pd->prli_svc_param_word_3[0] & BIT_5) == 0)
> +			fcport->port_type |= FCT_NVME_INITIATOR;
> +		if ((pd->prli_svc_param_word_3[0] & BIT_4) == 0)
> +			fcport->port_type |= FCT_NVME_TARGET;
> +		if ((pd->prli_svc_param_word_3[0] & BIT_3) == 0)
> +			fcport->port_type |= FCT_NVME_DISCOVERY;
>   	} else {
>   		/* If not target must be initiator or unknown type. */
>   		if ((pd->prli_svc_param_word_3[0] & BIT_4) == 0)
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index d7035270d274..0ff06d033b87 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -295,6 +295,9 @@ static const struct {
>   	{ FC_PORT_ROLE_FCP_INITIATOR,		"FCP Initiator" },
>   	{ FC_PORT_ROLE_IP_PORT,			"IP Port" },
>   	{ FC_PORT_ROLE_FCP_DUMMY_INITIATOR,	"FCP Dummy Initiator" },
> +	{ FC_PORT_ROLE_NVME_INITIATOR,		"NVMe Initiator" },
> +	{ FC_PORT_ROLE_NVME_TARGET,		"NVMe Target" },
> +	{ FC_PORT_ROLE_NVME_DISCOVERY,		"NVMe Discovery" },
>   };
>   fc_bitfield_name_search(port_roles, fc_port_role_names)
>   
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 2bb349035431..c48e96436f56 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -17,12 +17,6 @@
>   
>   
>   
> -/* FC Port role bitmask - can merge with FC Port Roles in fc transport */
> -#define FC_PORT_ROLE_NVME_INITIATOR	0x10
> -#define FC_PORT_ROLE_NVME_TARGET	0x20
> -#define FC_PORT_ROLE_NVME_DISCOVERY	0x40
> -
> -
>   /**
>    * struct nvme_fc_port_info - port-specific ids and FC connection-specific
>    *                            data element used during NVME Host role
> diff --git a/include/scsi/scsi_transport_fc.h b/include/scsi/scsi_transport_fc.h
> index 15da45dc2a5d..375c4dc641c2 100644
> --- a/include/scsi/scsi_transport_fc.h
> +++ b/include/scsi/scsi_transport_fc.h
> @@ -165,6 +165,9 @@ enum fc_tgtid_binding_type  {
>   #define FC_PORT_ROLE_FCP_INITIATOR		0x02
>   #define FC_PORT_ROLE_IP_PORT			0x04
>   #define FC_PORT_ROLE_FCP_DUMMY_INITIATOR	0x08
> +#define FC_PORT_ROLE_NVME_INITIATOR		0x10
> +#define FC_PORT_ROLE_NVME_TARGET		0x20
> +#define FC_PORT_ROLE_NVME_DISCOVERY		0x40
>   
>   /* The following are for compatibility */
>   #define FC_RPORT_ROLE_UNKNOWN			FC_PORT_ROLE_UNKNOWN

all-in-all, Looks ok.

Reviewed-by:??? James Smart? <james.smart at broadcom.com>

-- james
