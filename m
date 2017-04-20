From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:49:10 +0200
Subject: [PATCH-v1 18/22] Add Fabric assigned WWN support.
In-Reply-To: <20170420044641.10657-19-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-19-jsmart2021@gmail.com>
Message-ID: <20170420074910.GR6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:37PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> Adding support for Fabric assigned WWPN and WWNN.
> 
> Firmware sends first FLOGI to fabric with vendor version changes.
> On link up driver gets updated service parameter with FAWWN assigned port
> name.  Driver sends 2nd FLOGI with updated fawwpn and modifies the
> vport->fc_portname in driver.
> 
> Note:
> Soft wwpn will not be allowed when fawwpn is enabled.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

Aparrt form the superflous parenthesis like in this hunk:

> @@ -354,9 +356,26 @@ lpfc_update_vport_wwn(struct lpfc_vport *vport)
>  		memcpy(&vport->fc_sparam.nodeName, &vport->fc_nodename,
>  			sizeof(struct lpfc_name));
>  
> -	if (vport->fc_portname.u.wwn[0] == 0 || vport->phba->cfg_soft_wwpn)
> +	/*
> +	 * If the port name has changed, then set the Param changes flag
> +	 * to unreg the login
> +	 */
> +	if ((vport->fc_portname.u.wwn[0] != 0) &&
> +		memcmp(&vport->fc_portname, &vport->fc_sparam.portName,
> +			sizeof(struct lpfc_name)))
> +		vport->vport_flag |= FAWWPN_PARAM_CHG;
> +
> +	if ((vport->fc_portname.u.wwn[0] == 0) ||
> +	    (vport->phba->cfg_soft_wwpn) ||
> +	    (vvvl == 1 && (cpu_to_be32(*fawwpn_key)) == FAPWWN_KEY_VENDOR) ||
> +	    (vport->vport_flag & FAWWPN_SET)) {
>  		memcpy(&vport->fc_portname, &vport->fc_sparam.portName,
>  			sizeof(struct lpfc_name));
> +		vport->vport_flag &= ~FAWWPN_SET;
> +		if (vvvl == 1 && (cpu_to_be32(*fawwpn_key)) ==
> +		    FAPWWN_KEY_VENDOR)
> +			vport->vport_flag |= FAWWPN_SET;
> +	}


Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
