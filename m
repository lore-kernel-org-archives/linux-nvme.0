Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE9606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zdUJi19O;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f5E9QEei
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=67t7QrOlxDNg6taMwyQ/KECa8OfxWJNTPfo97m6ONUQ=; b=zdUJi19Osi6Hhb
	yRQTawXBmP8uCTIr68HPcrle+3l/UqioIMIhRsIFDzg78q1QcVkAOfLA8TLC66cdq9py3C2j4FjMt
	Izwdx80IecZh0FFB4avIRTZJES0MLJsKG7Rpwh36CX/a90FNS3uGBu0bjanwkiA0l8ItqhBxsjkpe
	2CkubojEbfulYLp737XATG8E74fCIaYpimO68lGKjhZ7Huyo1kTAsks8GiziH2x10SUaYvoxD2dvQ
	fNLKLm/k2E5caSxdPxvwsOvOC7oB2GWGCLwxnnbXn5JdY66ekCAh5/+cnW1kE8djHVwkhsdcAzLjo
	0e6bHJWjI8TkpYFJ7uJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyzd-00000006YTy-1HeJ;
	Wed, 28 Oct 2026 08:26:45 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyzZ-00000006YSw-3EF5
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 08:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793175999; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=67t7QrOlxDNg6taMwyQ/KECa8OfxWJNTPfo97m6ONUQ=;
	b=f5E9QEeiGe0J0kc/gu00msmbrvjVUPlrWynIwjS+Jly5DbDa5Y4In0xAh5w+/GjkSjkO+OK4B5tgYfyY8say9/fNaS/88QmdEImFT/G1ruC01+JYtwtWk58Gh7OYCc8c9JHh4hGJ6CMsqr7UYMn4XHwI1dKOBtDjBaKbBQOCoa8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0XDgF75f_1793175998;
Received: from 30.178.69.77(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDgF75f_1793175998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 16:26:39 +0800
Message-ID: <2b658f54-c394-4ed4-9999-e38c5a731aff@linux.alibaba.com>
Date: Wed, 28 Oct 2026 16:26:38 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Free the old negotiation state when restarting
 authentication
To: sashiko-reviews@lists.linux.dev
Cc: linux-nvme@lists.infradead.org
References: <20261028064345.544504-1-kanie@linux.alibaba.com>
 <sashiko-outbox-187572@kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <sashiko-outbox-187572@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_012641_981228_66890C8A 
X-CRM114-Status: GOOD (  17.27  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/28 14:59, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] nvmet-auth: NULL deref on restart due to stale dhchap_skey_len
> --
>
> commit b95a68b07cb2fd80ef9528e69f5467fefe0e42a1
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> nvmet: Free the old negotiation state when restarting authentication
>
> This commit calls nvmet_auth_sq_free() when restarting DH-HMAC-CHAP
> negotiation in nvmet_execute_auth_send() so that previously allocated
> c1, c2, and skey buffers on the submission queue are freed before a new
> round begins.
>
>> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
>> index 1fe21f2672f10..e68b1c6f2ce5a 100644
>> --- a/drivers/nvme/target/fabrics-cmd-auth.c
>> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
>> @@ -330,6 +330,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>>  			/* Restart negotiation */
>>  			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
>>  				 __func__, ctrl->cntlid, req->sq->qid);
>> +			nvmet_auth_sq_free(req->sq);
> [Severity: Critical]
> Can this trigger a NULL pointer dereference in nvmet_auth_host_hash() if
> the host restarts negotiation after generating a DH session key and then
> sends a reply with dhvlen == 0?
>
> In the first round, when a DH group is configured (ctrl->dh_gid !=
> NVME_AUTH_DHGROUP_NULL) and the host sends a reply with a non-zero dhvlen,
> nvmet_auth_reply() -> nvmet_auth_ctrl_sesskey() allocates
> req->sq->dhchap_skey and sets req->sq->dhchap_skey_len to the hash length.
> If that reply fails authentication with NVME_AUTH_DHCHAP_MESSAGE_FAILURE1,
> the host can send a new negotiate message to restart authentication.
>
> Calling nvmet_auth_sq_free() here frees sq->dhchap_skey and sets it to
> NULL, but leaves sq->dhchap_skey_len non-zero:
>
> drivers/nvme/target/auth.c:nvmet_auth_sq_free() {
> 	...
> 	kfree(sq->dhchap_skey);
> 	sq->dhchap_skey = NULL;
> }
>
> If the host then completes the negotiate and challenge steps and sends a
> reply with dhvlen == 0 in the second round, nvmet_auth_reply() skips
> nvmet_auth_ctrl_sesskey():
>
> drivers/nvme/target/fabrics-cmd-auth.c:nvmet_auth_reply() {
> 	...
> 	if (dhvlen) {
> 		if (!ctrl->dh_tfm)
> 			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> 		if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,
> 					    dhvlen) < 0)
> 			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> 	}
> 	...
> 	if (nvmet_auth_host_hash(req, response, data->hl) < 0) {
> }
>
> nvmet_auth_host_hash() then passes the NULL req->sq->dhchap_skey along with
> the stale non-zero req->sq->dhchap_skey_len to
> nvme_auth_augmented_challenge():
>
> drivers/nvme/target/auth.c:nvmet_auth_host_hash() {
> 	...
> 	if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
> 		challenge = kmalloc(shash_len, GFP_KERNEL);
> 		if (!challenge) {
> 			ret = -ENOMEM;
> 			goto out_free_response;
> 		}
> 		ret = nvme_auth_augmented_challenge(ctrl->shash_id,
> 						    req->sq->dhchap_skey,
> 						    req->sq->dhchap_skey_len,
> 						    req->sq->dhchap_c1,
> 						    challenge, shash_len);
> }
>
> Because skey_len is non-zero while skey is NULL,
> nvme_auth_augmented_challenge() -> nvme_auth_hmac() ->
> nvme_auth_hmac_init() dereferences NULL when preparing the HMAC key.
>
> Should nvmet_auth_sq_free() also reset sq->dhchap_skey_len = 0 (or should
> nvmet_auth_reply() require dhvlen != 0 when ctrl->dh_gid !=
> NVME_AUTH_DHGROUP_NULL)?
Sashiko is right, I should set dhchap_skey_len to zero in nvmet_auth_sq_free().
Changed in v2.
>


