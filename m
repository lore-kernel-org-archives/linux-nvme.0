Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C245CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3JsPp7t9dylCs9xbxUjmxsoIe9L+csYLw04dM+Vxo08=; b=ewCUGPF7ZswqPNFSKsbZODdTI/
	QFlXgcSTCTUxWH+hJgMIkiOy0K+y/2ozMV9eZO9bG85yh08pyUuGHUaYfFVJcuH594RMm3s3hS0Fk
	Ps8C6XtgBVFqxVCZdHHMa9hAUfDZt1oO+bVG9/xfVJGvdfkPNBJYfo8WO4/BUsymZcmlonE/ti/uM
	XC+xcJIKv38WEdeukAH90XlDTpfXZZjGEpDCC8EU117LnMsQQSrRWMCweW/5vAKJE9TMIgXts0ETy
	/dFaUulDnNBsmxOr5XKwCIq0jRHupE1xLGBqFyIhTkAtuDv9XIwW/Sn7xy4G1FuPxKu3p+Juq0H+R
	bwOoKALg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXepg-001O3q-Ng; Fri, 25 Mar 2022 07:58:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXepc-001O3W-KY
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 07:58:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B06841F38D;
 Fri, 25 Mar 2022 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648195078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JsPp7t9dylCs9xbxUjmxsoIe9L+csYLw04dM+Vxo08=;
 b=nXR1RBO7OTPe3WLymsxKRUf2ms58BpF/UcdKAJwAvPk3hQFXuDia3CRwvkvpEI1zvrJrl9
 yopkV+DLH/am8L65NRy+XR00tj5c5CVdPqmW6ViZNRptI6J3cKk+zsskaTqEqZHVK3k0y5
 d+BiUF7E1AW+F4M6ZYPKxyQ8eapQDBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648195078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JsPp7t9dylCs9xbxUjmxsoIe9L+csYLw04dM+Vxo08=;
 b=myuq9HYjEfgm0EfYh/1BX6RhEY31cNfreZo05rDaQVCKu9c29kQyFRKzGLGHG6arozV1+n
 nCuNB2jspVtQZABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84E1713A30;
 Fri, 25 Mar 2022 07:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uuw2HgZ2PWL7WwAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 25 Mar 2022 07:57:58 +0000
Message-ID: <0b4e8168-a9af-1e04-8849-264823074cd6@suse.de>
Date: Fri, 25 Mar 2022 08:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220323071303.14671-1-hare@suse.de>
 <20220323071303.14671-7-hare@suse.de>
 <fb9d1fb7-98e8-f592-8acc-997292097345@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <fb9d1fb7-98e8-f592-8acc-997292097345@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220325_005800_882770_D8D55637 
X-CRM114-Status: GOOD (  33.15  )
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

On 3/24/22 17:53, Chaitanya Kulkarni wrote:
> On 3/23/22 00:12, Hannes Reinecke wrote:
>> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
>> This patch adds two new fabric options 'dhchap_secret' to specify the
>> pre-shared key (in ASCII respresentation according to NVMe 2.0 section
>> 8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
>> the pre-shared controller key for bi-directional authentication of both
>> the host and the controller.
>> Re-authentication can be triggered by writing the PSK into the new
>> controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>    drivers/nvme/host/Kconfig   |   11 +
>>    drivers/nvme/host/Makefile  |    1 +
>>    drivers/nvme/host/auth.c    | 1140 +++++++++++++++++++++++++++++++++++
>>    drivers/nvme/host/auth.h    |   32 +
>>    drivers/nvme/host/core.c    |  141 ++++-
>>    drivers/nvme/host/fabrics.c |   79 ++-
>>    drivers/nvme/host/fabrics.h |    7 +
>>    drivers/nvme/host/nvme.h    |   31 +
>>    drivers/nvme/host/rdma.c    |    1 +
>>    drivers/nvme/host/tcp.c     |    1 +
>>    drivers/nvme/host/trace.c   |   32 +
>>    11 files changed, 1469 insertions(+), 7 deletions(-)
>>    create mode 100644 drivers/nvme/host/auth.c
>>    create mode 100644 drivers/nvme/host/auth.h
>>
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index d6d056963c06..dd0e91fb0615 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -91,3 +91,14 @@ config NVME_TCP
>>    	  from https://github.com/linux-nvme/nvme-cli.
>>    
>>    	  If unsure, say N.
>> +
>> +config NVME_AUTH
>> +	bool "NVM Express over Fabrics In-Band Authentication"
>> +	depends on NVME_CORE
>> +	select CRYPTO_HMAC
>> +	select CRYPTO_SHA256
>> +	select CRYPTO_SHA512
>> +	help
>> +	  This provides support for NVMe over Fabrics In-Band Authentication.
>> +
>> +	  If unsure, say N.
>> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
>> index 476c5c988496..7755f5e3b281 100644
>> --- a/drivers/nvme/host/Makefile
>> +++ b/drivers/nvme/host/Makefile
>> @@ -15,6 +15,7 @@ nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
>>    nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
>>    nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
>>    nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
>> +nvme-core-$(CONFIG_NVME_AUTH)		+= auth.o
>>    
>>    nvme-y					+= pci.o
>>    
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> new file mode 100644
>> index 000000000000..4bca4ba1ccea
>> --- /dev/null
>> +++ b/drivers/nvme/host/auth.c
>> @@ -0,0 +1,1140 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020 Hannes Reinecke, SUSE Linux
>> + */
>> +
>> +#include <linux/crc32.h>
>> +#include <linux/base64.h>
>> +#include <linux/prandom.h>
>> +#include <asm/unaligned.h>
>> +#include <crypto/hash.h>
>> +#include <crypto/dh.h>
>> +#include "nvme.h"
>> +#include "fabrics.h"
>> +#include "auth.h"
>> +
>> +static u32 nvme_dhchap_seqnum;
>> +static DEFINE_MUTEX(nvme_dhchap_mutex);
>> +
>> +struct nvme_dhchap_queue_context {
>> +	struct list_head entry;
>> +	struct work_struct auth_work;
>> +	struct nvme_ctrl *ctrl;
>> +	struct crypto_shash *shash_tfm;
>> +	void *buf;
>> +	size_t buf_size;
>> +	int qid;
>> +	int error;
>> +	u32 s1;
>> +	u32 s2;
>> +	u16 transaction;
>> +	u8 status;
>> +	u8 hash_id;
>> +	size_t hash_len;
>> +	u8 dhgroup_id;
>> +	u8 c1[64];
>> +	u8 c2[64];
>> +	u8 response[64];
>> +	u8 *host_response;
>> +};
>> +
>> +u32 nvme_auth_get_seqnum(void)
>> +{
>> +	u32 seqnum;
>> +
>> +	mutex_lock(&nvme_dhchap_mutex);
>> +	if (!nvme_dhchap_seqnum)
>> +		nvme_dhchap_seqnum = prandom_u32();
>> +	else {
>> +		nvme_dhchap_seqnum++;
>> +		if (!nvme_dhchap_seqnum)
>> +			nvme_dhchap_seqnum++;
>> +	}
>> +	seqnum = nvme_dhchap_seqnum;
>> +	mutex_unlock(&nvme_dhchap_mutex);
>> +	return seqnum;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_get_seqnum);
>> +
>> +static struct nvme_auth_dhgroup_map {
>> +	u8 id;
>> +	const char name[16];
>> +	const char kpp[16];
>> +} dhgroup_map[] = {
>> +	{ .id = NVME_AUTH_DHGROUP_NULL,
>> +	  .name = "null", .kpp = "null" },
>> +	{ .id = NVME_AUTH_DHGROUP_2048,
>> +	  .name = "ffdhe2048", .kpp = "ffdhe2048(dh)" },
>> +	{ .id = NVME_AUTH_DHGROUP_3072,
>> +	  .name = "ffdhe3072", .kpp = "ffdhe3072(dh)" },
>> +	{ .id = NVME_AUTH_DHGROUP_4096,
>> +	  .name = "ffdhe4096", .kpp = "ffdhe4096(dh)" },
>> +	{ .id = NVME_AUTH_DHGROUP_6144,
>> +	  .name = "ffdhe6144", .kpp = "ffdhe6144(dh)" },
>> +	{ .id = NVME_AUTH_DHGROUP_8192,
>> +	  .name = "ffdhe8192", .kpp = "ffdhe8192(dh)" },
>> +};
>> +
>> +const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
>> +		if (dhgroup_map[i].id == dhgroup_id)
>> +			return dhgroup_map[i].name;
>> +	}
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
>> +
>> +const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
>> +		if (dhgroup_map[i].id == dhgroup_id)
>> +			return dhgroup_map[i].kpp;
>> +	}
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
>> +
>> +u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
>> +		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
>> +			     strlen(dhgroup_map[i].name)))
>> +			return dhgroup_map[i].id;
>> +	}
>> +	return NVME_AUTH_DHGROUP_INVALID;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
>> +
>> +static struct nvme_dhchap_hash_map {
>> +	int id;
>> +	int len;
>> +	const char hmac[15];
>> +	const char digest[15];
>> +} hash_map[] = {
>> +	{.id = NVME_AUTH_HASH_SHA256, .len = 32,
>> +	 .hmac = "hmac(sha256)", .digest = "sha256" },
>> +	{.id = NVME_AUTH_HASH_SHA384, .len = 48,
>> +	 .hmac = "hmac(sha384)", .digest = "sha384" },
>> +	{.id = NVME_AUTH_HASH_SHA512, .len = 64,
>> +	 .hmac = "hmac(sha512)", .digest = "sha512" },
>> +};
>> +
>> +const char *nvme_auth_hmac_name(u8 hmac_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
>> +		if (hash_map[i].id == hmac_id)
>> +			return hash_map[i].hmac;
>> +	}
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
>> +
>> +const char *nvme_auth_digest_name(u8 hmac_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
>> +		if (hash_map[i].id == hmac_id)
>> +			return hash_map[i].digest;
>> +	}
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_digest_name);
>> +
>> +u8 nvme_auth_hmac_id(const char *hmac_name)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
>> +		if (!strncmp(hash_map[i].hmac, hmac_name,
>> +			     strlen(hash_map[i].hmac)))
>> +			return hash_map[i].id;
>> +	}
>> +	return NVME_AUTH_HASH_INVALID;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
>> +
>> +size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
>> +		if (hash_map[i].id == hmac_id)
>> +			return hash_map[i].len;
>> +	}
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
> 
> we can remove loops in the above helpers and the id member in
> the struct with the help of the sparse array, why not :-
> 
Sure, good idea. Will be doing that.

[ .. ]
>> +static int nvme_auth_receive(struct nvme_ctrl *ctrl, int qid,
>> +		void *buf, size_t al)
>> +{
>> +	struct nvme_command cmd = {};
>> +	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
>> +	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
>> +	int ret;
>> +
>> +	cmd.auth_receive.opcode = nvme_fabrics_command;
>> +	cmd.auth_receive.fctype = nvme_fabrics_type_auth_receive;
>> +	cmd.auth_receive.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
>> +	cmd.auth_receive.spsp0 = 0x01;
>> +	cmd.auth_receive.spsp1 = 0x01;
>> +	cmd.auth_receive.al = cpu_to_le32(al);
>> +
>> +	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, buf, al, 0,
>> +				     qid == 0 ? NVME_QID_ANY : qid,
>> +				     0, flags);
>> +	if (ret > 0) {
>> +		dev_warn(ctrl->device,
>> +			 "qid %d auth_recv failed with status %x\n", qid, ret);
>> +		ret = -EIO;
>> +	} else if (ret < 0) {
>> +		dev_err(ctrl->device,
>> +			"qid %d auth_recv failed with error %d\n", qid, ret);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> 
> Why not use something like this ? It reduces the duplicate code and
> need for macros :-
> 
> static int nvme_auth_send_recv_common(bool send, struct nvme_ctrl *ctrl,
>                                         int qid, void *buf, size_t buflen)
> 
> {
>           strucy nvme_cmd cmd = { };
>           blk_mq_req_flags_t flags;
>           struct request_queue *q;
>           int ret;
> 
>           flags = qid == 0 ? 0 : BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT;
>           q = qid == 0 ? ctrl->fabrics_q : ctrl->connect_q;
> 
>           /* auth send/recv share common offset for the various fields in
> cmd */
>           cmd.auth_send.opcode = nvme_fabrics_command;
>           cmd.auth_send.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
>           cmd.auth_send.spsp0 = 0x01;
>           cmd.auth_send.spsp1 = 0x01;
>           cmd.auth_send.al = cpu_to_le32(buflen);
>           cmd.auth_receive.fctype = send ? nvme_fabrics_type_auth_send :
>                                            nvme_fabrics_type_auth_receive;
> 
>           ret = nvme_submit_sync_cmd(q, &cmd, NULL, buf, buflen, 0,
>                                      qid == 0 ? NVME_QID_ANY : qid,
>                                      0, flags);
>           if (ret > 0)
>                   dev_warn(ctrl->device,
>                           "qid %d fctype 0x%x failed with status %d\n", qid,
>                           cmd.auth_send.fctype, ret);
>           else if (ret < 0)
>                   dev_err(ctrl->device,
>                           "qid %d fctype 0x%x failed with error %d\n", qid,
>                           cmd.auth_send.fctype, ret);
>           return ret;
> }
> 
> 
Naa. If we were going down that route we should add a new structure for 
nvme_auth_common, and use that for the common function.
And then the wrapper can just cast nvme_auth_send and nvme_auth_recv to 
the common structure.
I'll give it a go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

