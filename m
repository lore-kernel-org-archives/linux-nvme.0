Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A118C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 09:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDktBSwIfx+P3GXxllHDo/fc3YH4zU2/L9Nes1bCDaU=; b=28kavkI/7KiaaMVwjR+Pi58T8a
	fRl1zr1I/5x+lQznZW1lNugg5HS9B4iIoRGm32qOvsNCQsPuzcsDIbp2FisVAjIimqDjzpEO6mU9G
	vOm3FNL6zjSaorzwP5PerdKiic/yOame0Fk/RwQySX3pQCzbHiaYt09jPawmw2znhQfXQPKFShwwh
	tCrFvQdnEayIpV0sMNA8PQnLNAMcIdeG4ugfIRz1+gfvPM7W5Vn2ZMOf5Q+wx0axZrxRI69L8uEAs
	99IDNLSW4koq8/+0f5+R7O6iGBaIH7tCQDdmKSLIzNFk/iIrHjQngaxyRFAj51WKw8MunvRaWf6Kj
	/hi2S4hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1Ng-00Ey53-MM; Thu, 27 Jan 2022 09:47:53 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD178-00EuHB-RN
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 09:30:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B38041F37E;
 Thu, 27 Jan 2022 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDktBSwIfx+P3GXxllHDo/fc3YH4zU2/L9Nes1bCDaU=;
 b=iEjIHdQJ8heFc/wzOYjj39hWVHl+Ir+lpezQeCvM8x6bzLVEJYzMF0JnC9kHtgtWdo62ll
 Y91BjKf32gLDewewDSqqydvEYZiuVaiDHdsgnpmtLC1W6W+8Rcx87GpVlcqNbCCkcdEnXW
 CtP2Z9SewJkVPXVWd93zH4hEJGGr/fI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDktBSwIfx+P3GXxllHDo/fc3YH4zU2/L9Nes1bCDaU=;
 b=e846nAEPbhNYdiubxXncAaGzoRwbaAogQoXpLj41RBtmF6UFnJWSZvZAVYtKFNmz1hVa/Z
 PxHkCyM2IWVtCqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EED313CFB;
 Thu, 27 Jan 2022 09:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ED9mJkRm8mFtIwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 09:30:44 +0000
Message-ID: <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
Date: Thu, 27 Jan 2022 10:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
In-Reply-To: <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_013047_255585_73EBDC33 
X-CRM114-Status: GOOD (  39.29  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/25/22 15:59, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces Central Discovery Controllers (CDC) and the
> Discovery Information Management (DIM) PDU, which is used to
> perform explicit registration with Discovery Controllers.
> 
> This patch defines the DIM PDU and adds logic to perform explicit
> registration with DCs when registration has been requested by the
> user.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/fabrics.c | 164 +++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |   9 ++
>   drivers/nvme/host/tcp.c     |  51 +++++++-
>   include/linux/nvme.h        | 255 ++++++++++++++++++++++++++++++++++--
>   4 files changed, 467 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 040a6cce6afa..e6fc2f85b670 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -10,6 +10,7 @@
>   #include <linux/mutex.h>
>   #include <linux/parser.h>
>   #include <linux/seq_file.h>
> +#include <linux/utsname.h>
>   #include "nvme.h"
>   #include "fabrics.h"
>   
> @@ -526,6 +527,165 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
>   	return NULL;
>   }
>   
> +/**
> + * nvmf_get_tel() - Calculate the amount of memory needed for a Discovery
> + * Information Entry. Each Entry must contain at a minimum an Extended
> + * Attribute for the HostID. The Entry may optionally contain an Extended
> + * Attribute for the Symbolic Name.
> + *
> + * @hostsymname - Symbolic name (may be NULL)
> + *
> + * Return Total Entry Length
> + */
> +static u32 nvmf_get_tel(const char *hostsymname)
> +{
> +	u32 tel = SIZEOF_EXT_DIE_WO_EXAT;
> +	u16 len;
> +
> +	/* Host ID is mandatory */
> +	tel += exat_size(sizeof(uuid_t));
> +
> +	/* Symbolic name is optional */
> +	len = hostsymname ? strlen(hostsymname) : 0;
> +	if (len)
> +		tel += exat_size(len);
> +
> +	return tel;
> +}
> +
> +/**
> + * nvmf_fill_die() - Fill the Discovery Information Entry pointed to by
> + *                   @die.
> + *
> + * @die - Pointer to Discovery Information Entry to be filled
> + * @tel - Length of the DIE
> + * @trtype - Transport type
> + * @adrfam - Address family
> + * @reg_addr - Address to register. Setting this to an empty string tells
> + *       the DC to infer address from the source address of the socket.
> + * @nqn - Host NQN
> + * @hostid - Host ID
> + * @hostsymname - Host symbolic name
> + * @tsas - Transport Specific Address Subtype for the address being
> + *       registered.
> + */
> +static void nvmf_fill_die(struct nvmf_ext_die  *die,
> +			  u32                   tel,
> +			  u8                    trtype,
> +			  u8                    adrfam,
> +			  const char           *reg_addr,
> +			  struct nvmf_host     *host,
> +			  union nvmf_tsas      *tsas)
> +{
> +	u16 numexat = 0;
> +	size_t symname_len;
> +	struct nvmf_ext_attr *exat;
> +
> +	die->tel = cpu_to_le32(tel);
> +	die->trtype = trtype;
> +	die->adrfam = adrfam;
> +
> +	strncpy(die->nqn, host->nqn, sizeof(die->nqn));
> +	strncpy(die->traddr, reg_addr, sizeof(die->traddr));
> +	memcpy(&die->tsas, tsas, sizeof(die->tsas));
> +
> +	/* Extended Attribute for the HostID (mandatory) */
> +	numexat++;
> +	exat = &die->exat;
> +	exat->type = cpu_to_le16(NVME_EXATTYPE_HOSTID);
> +	exat->len  = cpu_to_le16(exat_len(sizeof(host->id)));
> +	uuid_copy((uuid_t *)exat->val, &host->id);
> +
> +	/* Extended Attribute for the Symbolic Name (optional) */
> +	symname_len = strlen(host->symname);
> +	if (symname_len) {
> +		u16 exatlen = exat_len(symname_len);
> +
> +		numexat++;
> +		exat = exat_ptr_next(exat);
> +		exat->type = cpu_to_le16(NVME_EXATTYPE_SYMNAME);
> +		exat->len  = cpu_to_le16(exatlen);
> +		memcpy(exat->val, host->symname, symname_len);
> +		/* Per Base specs, ASCII strings must be padded with spaces */
> +		memset(&exat->val[symname_len], ' ', exatlen - symname_len);
> +	}
> +
> +	die->numexat = cpu_to_le16(numexat);
> +}
> +
> +/**
> + * nvmf_disc_info_mgmt() - Perform explicit registration, deregistration,
> + * or registration-update (specified by @tas) by sending a Discovery
> + * Information Management (DIM) command to the Discovery Controller (DC).
> + *
> + * @ctrl: Host NVMe controller instance maintaining the admin queue used to
> + *      submit the DIM command to the DC.
> + * @tas: Task field of the Command Dword 10 (cdw10). Indicates whether to
> + *     perform a Registration, Deregistration, or Registration-update.
> + * @trtype: Transport type (e.g. NVMF_TRTYPE_TCP)
> + * @adrfam: Address family (e.g. NVMF_ADDR_FAMILY_IP6)
> + * @reg_addr - Address to register. Setting this to an empty string tells
> + *       the DC to infer address from the source address of the socket.
> + * @tsas - Transport Specific Address Subtype for the address being
> + *       registered.
> + *
> + * Return:   0: success,
> + *         > 0: NVMe error status code,
> + *         < 0: Linux errno error code
> + */
> +int nvmf_disc_info_mgmt(struct nvme_ctrl *ctrl,
> +			enum nvmf_dim_tas tas,
> +			u8                trtype,
> +			u8                adrfam,
> +			const char       *reg_addr,
> +			union nvmf_tsas  *tsas)
> +{
> +	int                   ret;
> +	u32                   tdl;  /* Total Data Length */
> +	u32                   tel;  /* Total Entry Length */
> +	struct nvmf_dim_data *dim;  /* Discovery Information Management */
> +	struct nvmf_ext_die  *die;  /* Discovery Information Entry */
> +	struct nvme_command   cmd = {};
> +	union nvme_result     result;
> +
> +	/* Register 1 Discovery Information Entry (DIE) of size TEL */
> +	tel = nvmf_get_tel(ctrl->opts->host->symname);
> +	tdl = SIZEOF_DIM_WO_DIE + tel;
> +
> +	dim = kzalloc(tdl, GFP_KERNEL);
> +	if (!dim)
> +		return -ENOMEM;
> +
> +	cmd.dim.opcode = nvme_admin_dim;
> +	cmd.dim.cdw10  = cpu_to_le32(tas);
> +
> +	dim->tdl    = cpu_to_le32(tdl);
> +	dim->nument = cpu_to_le64(1);    /* only 1 DIE to register */
> +	dim->entfmt = cpu_to_le16(NVME_ENTFMT_EXTENDED);
> +	dim->etype  = cpu_to_le16(NVME_REGISTRATION_HOST);
> +	dim->ektype = cpu_to_le16(0x5F); /* must be 0x5F per specs */
> +
> +	strncpy(dim->eid, ctrl->opts->host->nqn, sizeof(dim->eid));
> +	strncpy(dim->ename, utsname()->nodename, sizeof(dim->ename));
> +	strncpy(dim->ever, utsname()->release, sizeof(dim->ever));
> +
> +	die = &dim->die.extended;
> +	nvmf_fill_die(die, tel, trtype, adrfam, reg_addr,
> +		      ctrl->opts->host, tsas);
> +
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &result,
> +				     dim, tdl, 0, NVME_QID_ANY, 1, 0);
> +	if (unlikely(ret)) {
> +		dev_err(ctrl->device, "DIM error Result:0x%04X Status:0x%04X\n",
> +		   le32_to_cpu(result.u32), ret);
> +	}
> +
> +	kfree(dim);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvmf_disc_info_mgmt);
> +
>   static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TRANSPORT,		"transport=%s"		},
>   	{ NVMF_OPT_TRADDR,		"traddr=%s"		},
> @@ -550,6 +710,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
> +	{ NVMF_OPT_REGISTER,		"register"		},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -831,6 +992,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> +		case NVMF_OPT_REGISTER:
> +			opts->explicit_registration = true;
> +			break;
>   		case NVMF_OPT_SYMNAME:
>   			hostsymname = match_strdup(args);
>   			if (!hostsymname) {
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 494e6dbe233a..77f5768f8ff4 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -70,6 +70,7 @@ enum {
>   	NVMF_OPT_HOST_IFACE	= 1 << 21,
>   	NVMF_OPT_DISCOVERY	= 1 << 22,
>   	NVMF_OPT_SYMNAME	= 1 << 23,
> +	NVMF_OPT_REGISTER	= 1 << 24,
>   };
>   
>   /**
> @@ -106,6 +107,7 @@ enum {
>    * @nr_poll_queues: number of queues for polling I/O
>    * @tos: type of service
>    * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
> + * @explicit_registration: Explicit Registration with DC using the DIM PDU
>    */
>   struct nvmf_ctrl_options {
>   	unsigned		mask;
> @@ -130,6 +132,7 @@ struct nvmf_ctrl_options {
>   	unsigned int		nr_poll_queues;
>   	int			tos;
>   	int			fast_io_fail_tmo;
> +	bool			explicit_registration;
>   };
>   
>   /*
> @@ -200,5 +203,11 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
> +int nvmf_disc_info_mgmt(struct nvme_ctrl *ctrl,
> +			enum nvmf_dim_tas tas,
> +			u8                trtype,
> +			u8                adrfam,
> +			const char       *reg_addr,
> +			union nvmf_tsas  *tsas);
>   
>   #endif /* _NVME_FABRICS_H */
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4ceb28675fdf..970b7df574a4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1993,6 +1993,40 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   	}
>   }
>   
> +/**
> + * nvme_get_adrfam() - Get address family for the address we're registering
> + * with the DC. We retrieve this info from the socket itself. If we can't
> + * get the source address from the socket, then we'll infer the address
> + * family from the address of the DC since the DC address has the same
> + * address family.
> + *
> + * @ctrl: Host NVMe controller instance maintaining the admin queue used to
> + *      submit the DIM command to the DC.
> + *
> + * Return: The address family of the source address associated with the
> + * socket connected to the DC.
> + */
> +static u8 nvme_get_adrfam(struct nvme_ctrl *ctrl)
> +{
> +	u8                       adrfam = NVMF_ADDR_FAMILY_IP4;
> +	struct sockaddr_storage  sas;
> +	struct sockaddr         *sa = (struct sockaddr *)&sas;
> +	struct nvme_tcp_queue   *queue = &to_tcp_ctrl(ctrl)->queues[0];
> +
> +	if (kernel_getsockname(queue->sock, sa) == 0) {
> +		if (sa->sa_family == AF_INET6)
> +			adrfam = NVMF_ADDR_FAMILY_IP6;
> +	} else {
> +		unsigned char buf[sizeof(struct in6_addr)];
> +
> +		if (in6_pton(ctrl->opts->traddr,
> +			     strlen(ctrl->opts->traddr), buf, -1, NULL) > 0)
> +			adrfam = NVMF_ADDR_FAMILY_IP6;
> +	}
> +
> +	return adrfam;
> +}
> +
>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->opts;
> @@ -2045,6 +2079,20 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		goto destroy_io;
>   	}
>   
> +	if (ctrl->opts->explicit_registration &&
> ++	    ((ctrl->dctype == NVME_DCTYPE_DDC) ||
> +	     (ctrl->dctype == NVME_DCTYPE_CDC))) {
> +		/* We're registering our source address with the DC. To do
> +		 * that, we can simply send an empty string. This tells the DC
> +		 * to retrieve the source address from the socket and use that
> +		 * as the registration address.
> +		 */
> +		union nvmf_tsas tsas = {.tcp.sectype = NVMF_TCP_SECTYPE_NONE};
> +
> +		nvmf_disc_info_mgmt(ctrl, NVME_TAS_REGISTER, NVMF_TRTYPE_TCP,
> +				    nvme_get_adrfam(ctrl), "", &tsas);
> +	}
> +
>   	nvme_start_ctrl(ctrl);
>   	return 0;
>   
> @@ -2613,7 +2661,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE |
> +			  NVMF_OPT_REGISTER,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 3b47951342f4..891615876cfa 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -9,6 +9,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/uuid.h>
> +#include <linux/kernel.h>
>   
>   /* NQN names in commands fields specified one size */
>   #define NVMF_NQN_FIELD_LEN	256
> @@ -102,6 +103,16 @@ enum {
>   	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
>   };
>   
> +/**
> + * enum -
> + * @NVMF_TCP_SECTYPE_NONE: No Security
> + * @NVMF_TCP_SECTYPE_TLS:  Transport Layer Security
> + */
> +enum {
> +	NVMF_TCP_SECTYPE_NONE	= 0,
> +	NVMF_TCP_SECTYPE_TLS	= 1,
> +};
> +
>   #define NVME_AQ_DEPTH		32
>   #define NVME_NR_AEN_COMMANDS	1
>   #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
> @@ -1036,6 +1047,7 @@ enum nvme_admin_opcode {
>   	nvme_admin_sanitize_nvm		= 0x84,
>   	nvme_admin_get_lba_status	= 0x86,
>   	nvme_admin_vendor_start		= 0xC0,
> +	nvme_admin_dim			= 0x21,
>   };
>   
>   #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
> @@ -1316,6 +1328,29 @@ struct nvmf_common_command {
>   	__u8	ts[24];
>   };
>   
> +/**
> + * union nvmf_tsas - Transport Specific Address Subtype
> + * @qptype:  Queue Pair Service Type (NVMF_RDMA_QPTYPE_CONNECTED, NVMF_RDMA_QPTYPE_DATAGRAM)
> + * @prtype:  Provider Type (see enum  nvme_rdma_prtype)
> + * @cma:     Connection Management Service (NVMF_RDMA_CMS_RDMA_CM)
> + * @pkey:    Partition Key
> + * @sectype: Security Type (NVMF_TCP_SECTYPE_NONE, NVMF_TCP_SECTYPE_TLS)
> + */
> +union nvmf_tsas {
> +	char		common[NVMF_TSAS_SIZE];
> +	struct rdma {
> +		__u8	qptype;
> +		__u8	prtype;
> +		__u8	cms;
> +		__u8	rsvd3[5];
> +		__u16	pkey;
> +		__u8	rsvd10[246];
> +	} rdma;
> +	struct tcp {
> +		__u8	sectype;
> +	} tcp;
> +};
> +
>   /*
>    * The legal cntlid range a NVMe Target will provide.
>    * Note that cntlid of value 0 is considered illegal in the fabrics world.
> @@ -1349,17 +1384,7 @@ struct nvmf_disc_rsp_page_entry {
>   	__u8		resv64[192];
>   	char		subnqn[NVMF_NQN_FIELD_LEN];
>   	char		traddr[NVMF_TRADDR_SIZE];
> -	union tsas {
> -		char		common[NVMF_TSAS_SIZE];
> -		struct rdma {
> -			__u8	qptype;
> -			__u8	prtype;
> -			__u8	cms;
> -			__u8	resv3[5];
> -			__u16	pkey;
> -			__u8	resv10[246];
> -		} rdma;
> -	} tsas;
> +	union nvmf_tsas tsas;
>   };
>   
>   /* Discovery log page header */
> @@ -1447,6 +1472,213 @@ struct streams_directive_params {
>   	__u8	rsvd2[6];
>   };
>   
> +/**
> + * Discovery Information Management (DIM) command. This is sent by a
> + * host to the Central Discovery Controller (CDC) to perform
> + * explicit registration.
> + */
> +enum nvmf_dim_tas {
> +	NVME_TAS_REGISTER   = 0x00,
> +	NVME_TAS_DEREGISTER = 0x01,
> +	NVME_TAS_UPDATE     = 0x02,
> +};
> +
> +struct nvmf_dim_command {
> +	__u8                  opcode;     /* nvme_admin_dim */
> +	__u8                  flags;
> +	__u16                 command_id;
> +	__le32                nsid;
> +	__u64                 rsvd2[2];
> +	union nvme_data_ptr   dptr;
> +	__le32                cdw10;      /* enum nvmf_dim_tas */
> +	__le32                cdw11;
> +	__le32                cdw12;
> +	__le32                cdw13;
> +	__le32                cdw14;
> +	__le32                cdw15;
> +};
> +
> +#define NVMF_ENAME_LEN    256
> +#define NVMF_EVER_LEN     64
> +
> +enum nvmf_dim_entfmt {
> +	NVME_ENTFMT_BASIC    = 0x01,
> +	NVME_ENTFMT_EXTENDED = 0x02,
> +};
> +
> +enum nvmf_dim_etype {
> +	NVME_REGISTRATION_HOST = 0x01,
> +	NVME_REGISTRATION_DDC  = 0x02,
> +	NVME_REGISTRATION_CDC  = 0x03,
> +};
> +
> +enum nvmf_exattype {
> +	NVME_EXATTYPE_HOSTID   = 0x01, /* Host Identifier */
> +	NVME_EXATTYPE_SYMNAME  = 0x02, /* Symbolic Name */
> +};
> +
> +/**
> + * struct nvmf_ext_attr - Extended Attribute (EXAT)
> + *
> + *       Bytes       Description
> + * @type 01:00       Extended Attribute Type (EXATTYPE) - enum nvmf_exattype
> + * @len  03:02       Extended Attribute Length (EXATLEN)
> + * @val  (EXATLEN-1) Extended Attribute Value (EXATVAL) - size allocated
> + *       +4:04       for array must be a multiple of 4 bytes
> + */
> +struct nvmf_ext_attr {
> +	__le16			type;
> +	__le16			len;
> +	__u8			val[];
> +};
> +#define SIZEOF_EXT_EXAT_WO_VAL offsetof(struct nvmf_ext_attr, val)
> +
> +/**
> + * struct nvmf_ext_die - Extended Discovery Information Entry (DIE)
> + *
> + *            Bytes           Description
> + * @trtype    00              Transport Type (enum nvme_trtype)
> + * @adrfam    01              Address Family (enum nvmf_addr_familiy)
> + * @subtype   02              Subsystem Type (enum nvme_subsys_type)
> + * @treq      03              Transport Requirements (enum nvmf_treq)
> + * @portid    05:04           Port ID
> + * @cntlid    07:06           Controller ID
> + * @asqsz     09:08           Admin Max SQ Size
> + *            31:10           Reserved
> + * @trsvcid   63:32           Transport Service Identifier
> + *            255:64          Reserved
> + * @nqn       511:256         NVM Qualified Name
> + * @traddr    767:512         Transport Address
> + * @tsas      1023:768        Transport Specific Address Subtype
> + * @tel       1027:1024       Total Entry Length
> + * @numexat   1029:1028       Number of Extended Attributes
> + *            1031:1030       Reserved
> + * @exat[0]   ((EXATLEN-1)+   Extented Attributes 0 (see @numexat)
> + *            4)+1032:1032    Cannot access as an array because each EXAT
> + *                            entry has an undetermined size.
> + * @exat[N]   TEL-1:TEL-      Extented Attributes N (w/ N = NUMEXAT-1)
> + *            (EXATLEN+4)
> + */
> +struct nvmf_ext_die {
> +	__u8			trtype;
> +	__u8			adrfam;
> +	__u8			subtype;
> +	__u8			treq;
> +	__le16			portid;
> +	__le16			cntlid;
> +	__le16			asqsz;
> +	__u8			resv10[22];
> +	char			trsvcid[NVMF_TRSVCID_SIZE];
> +	__u8			resv64[192];
> +	char			nqn[NVMF_NQN_FIELD_LEN];
> +	char			traddr[NVMF_TRADDR_SIZE];
> +	union nvmf_tsas		tsas;
> +	__le32			tel;
> +	__le16			numexat;
> +	__u16			resv1030;
> +	struct nvmf_ext_attr	exat;
> +};
> +#define SIZEOF_EXT_DIE_WO_EXAT offsetof(struct nvmf_ext_die, exat)
> +
> +/**
> + * union nvmf_die - Discovery Information Entry (DIE)
> + *
> + * Depending on the ENTFMT specified in the DIM, DIEs can be entered with
> + * the Basic or Extended formats. For Basic format, each entry has a fixed
> + * length. Therefore, the "basic" field defined below can be accessed as a
> + * C array. For the Extended format, however, each entry is of variable
> + * length (TEL). Therefore, the "extended" field defined below cannot be
> + * accessed as a C array. Instead, the "extended" field is akin to a
> + * linked-list, where one can "walk" through the list. To move to the next
> + * entry, one simply adds the current entry's length (TEL) to the "walk"
> + * pointer. The number of entries in the list is specified by NUMENT.
> + * Although extended entries are of a variable lengths (TEL), TEL is
> + * always a multiple of 4 bytes.
> + */
> +union nvmf_die {
> +	struct nvmf_disc_rsp_page_entry	basic[0];
> +	struct nvmf_ext_die		extended;
> +};
> +
> +/**
> + * struct nvmf_dim_data - Discovery Information Management (DIM) - Data
> + *
> + *            Bytes       Description
> + * @tdl       03:00       Total Data Length
> + *            07:04       Reserved
> + * @nument    15:08       Number of entries
> + * @entfmt    17:16       Entry Format (enum nvmf_dim_entfmt)
> + * @etype     19:18       Entity Type (enum nvmf_dim_etype)
> + * @portlcL   20          Port Local
> + *            21          Reserved
> + * @ektype    23:22       Entry Key Type
> + * @eid       279:24      Entity Identifier (e.g. Host NQN)
> + * @ename     535:280     Entity Name (e.g. hostname)
> + * @ever      599:536     Entity Version (e.g. OS Name/Version)
> + *            1023:600    Reserved
> + * @die       TDL-1:1024  Discovery Information Entry (see @nument above)
> + */
> +struct nvmf_dim_data {
> +	__le32			tdl;
> +	__u32			rsvd4;
> +	__le64			nument;
> +	__le16			entfmt;
> +	__le16			etype;
> +	__u8			portlcl;
> +	__u8			rsvd21;
> +	__le16			ektype;
> +	char			eid[NVMF_NQN_FIELD_LEN];
> +	char			ename[NVMF_ENAME_LEN];
> +	char			ever[NVMF_EVER_LEN];
> +	__u8			rsvd600[424];
> +	union nvmf_die		die;
> +};
> +#define SIZEOF_DIM_WO_DIE offsetof(struct nvmf_dim_data, die)
> +
> +/**
> + * exat_len() - Return the size in bytes, rounded to a multiple of 4 ((i.e.
> + *         size of u32), of the buffer needed to hold the exat value of
> + *         size @val_len.
> + */
> +static inline u16 exat_len(size_t val_len)
> +{
> +	return (u16)round_up(val_len, sizeof(u32));
> +}
> +
> +/**
> + * exat_size - return the size of the "struct nvmf_ext_attr"
> + *   needed to hold a value of size @val_len.
> + *
> + * @val_len: This is the length of the data to be copied to the "val"
> + *         field of a "struct nvmf_ext_attr".
> + *
> + * @return The size in bytes, rounded to a multiple of 4 (i.e. size of
> + *         u32), of the "struct nvmf_ext_attr" required to hold a string of
> + *         length @val_len.
> + */
> +static inline u16 exat_size(size_t val_len)
> +{
> +	return (u16)(SIZEOF_EXT_EXAT_WO_VAL + exat_len(val_len));
> +}
> +
> +/**
> + * exat_ptr_next - Increment @p to the next element in the array. Extended
> + *   attributes are saved to an array of "struct nvmf_ext_attr" where each
> + *   element of the array is of variable size. In order to move to the next
> + *   element in the array one must increment the pointer to the current
> + *   element (@p) by the size of the current element.
> + *
> + * @p: Pointer to an element of an array of "struct nvmf_ext_attr".
> + *
> + * @return Pointer to the next element in the array.
> + */
> +static inline struct nvmf_ext_attr *exat_ptr_next(struct nvmf_ext_attr *p)
> +{
> +	return (struct nvmf_ext_attr *)
> +		((uintptr_t)p + (ptrdiff_t)exat_size(le16_to_cpu(p->len)));
> +}
> +
> +
>   struct nvme_command {
>   	union {
>   		struct nvme_common_command common;
> @@ -1470,6 +1702,7 @@ struct nvme_command {
>   		struct nvmf_property_get_command prop_get;
>   		struct nvme_dbbuf dbbuf;
>   		struct nvme_directive_cmd directive;
> +		struct nvmf_dim_command dim;
>   	};
>   };
>   
I'd rather like to have the TLS bits in a separate patch; they are not 
strictly related to this issue.

And I have a rather general issue with this: Is it required to issue an 
explicit registration directly after sending the 'connect' command?
IE do we need to have it as part of the 'connect' routine?

Thing is, the linux 'connect' routine is doing several things in one go
(like establishing a transport association for the admin queue, send the 
'connect' command for the admin queue, create transport associations for 
I/O queues and send 'connect' commands on all I/O queues, _and_ possibly 
do authentication, too).
If we now start overloading it with yet more functionality it becomes 
extremely hard to cleanup after an error, and that doesn't even mention 
the non-existing error reporting to userspace.

Wouldn't it make more sense to delegate explicit registration to 
userspace (ie libnvme/nvme-cli), and leave the kernel out of it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

