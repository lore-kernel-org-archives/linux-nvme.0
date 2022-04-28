Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411CC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 06:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MgHqI4A6HVtKu4JIu++3vQjMCSNgrOUjNOruZPiL0M=; b=upnamm6khUortS7DoZQfQQN0PW
	Tiptp2ZtTOUWIWjMiESTJ08ApUc8iEG6uIgxUxqHgmHNFpPiJFtmsAgMl4tRx3aGdDVCFbZXCWpcf
	R0Whl6XjTBP0m3pw5OB7xVYz69snvve6KRsrsPHkTQgfxO5FKayNeOBnlibrLDjsCg4gM5OpFXhE/
	Xl38/CHrw5CkVdv8MtlaNfKCWjVDvF5LiziMDt8FFStO2OMEoKL5A11aQI163eyzT654X3sjY2332
	fELzuTLbZtw6J8/Xw4IzhqRQTjCqkAyFGVZlxiRHiP+2bNKDJFds463PVzvM5eCuVT3RuvvulC5A4
	lK5s5sAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njxHh-004pL8-7n; Thu, 28 Apr 2022 06:05:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njxHd-004pJz-1E
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 06:05:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 570E21F746;
 Thu, 28 Apr 2022 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651125939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MgHqI4A6HVtKu4JIu++3vQjMCSNgrOUjNOruZPiL0M=;
 b=xFk/aSyj1liRQvMTBVSmsObIkYuyS8ghKg+SIX5PHmIOwaNOoyW+UP1tDB85lRt615s6x2
 hi2Bta4rm82A8jQOUvG7N3QAA5lXcn0cBANgtv2vcLUv1DKMTFi2UQdluBVeRVFXz7bb4e
 kKoMO3BjCtF6CGXW1/K+9GLO2BqADZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651125939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MgHqI4A6HVtKu4JIu++3vQjMCSNgrOUjNOruZPiL0M=;
 b=bL83y44eXH934mSFU7ng1Jm0AK95C4/dITtyVssQMSeZeH6UsJ5Sn59T4ZVwohlPpnUvcG
 ud6NN8tra92DN1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 369E113A8C;
 Thu, 28 Apr 2022 06:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MeOSDLMuamJrRwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 28 Apr 2022 06:05:39 +0000
Message-ID: <c2329901-ead3-4dd8-ed0e-95d79d0d579a@suse.de>
Date: Thu, 28 Apr 2022 08:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: "Nayak, Prashanth" <Prashanth.Nayak@netapp.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220328133938.146146-1-hare@suse.de>
 <20220328133938.146146-7-hare@suse.de>
 <AC1767B2-F6F0-4DE9-A0C4-F15D45DB9E79@netapp.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <AC1767B2-F6F0-4DE9-A0C4-F15D45DB9E79@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_230545_414402_F378B31D 
X-CRM114-Status: GOOD (  23.06  )
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

On 4/27/22 19:59, Nayak, Prashanth wrote:
> Hi Hannes
> 
>> On Mar 28, 2022, at 9:39 AM, Hannes Reinecke <hare@suse.de> wrote:
>>
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
>> drivers/nvme/host/Kconfig   |   11 +
>> drivers/nvme/host/Makefile  |    1 +
>> drivers/nvme/host/auth.c    | 1123 +++++++++++++++++++++++++++++++++++
>> drivers/nvme/host/auth.h    |   32 +
>> drivers/nvme/host/core.c    |  141 ++++-
>> drivers/nvme/host/fabrics.c |   79 ++-
>> drivers/nvme/host/fabrics.h |    7 +
>> drivers/nvme/host/nvme.h    |   31 +
>> drivers/nvme/host/rdma.c    |    1 +
>> drivers/nvme/host/tcp.c     |    1 +
>> drivers/nvme/host/trace.c   |   32 +
>> 11 files changed, 1452 insertions(+), 7 deletions(-)
>> create mode 100644 drivers/nvme/host/auth.c
>> create mode 100644 drivers/nvme/host/auth.h
>>
[ .. ]
>> +static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
>> +		struct nvme_dhchap_queue_context *chap)
>> +{
>> +	struct nvmf_auth_dhchap_failure_data *data = chap->buf;
>> +	size_t size = sizeof(*data);
>> +
>> +	memset(chap->buf, 0, size);
>> +	data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
> 
> Auth_type should be NVME_AUTH_COMMON_MESSAGES.
> 

Right.

>> +	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
>> +	data->t_id = cpu_to_le16(chap->transaction);
>> +	data->rescode = NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED;
>> +	data->rescode_exp = chap->status;
>> +
>> +	return size;
>> +}
>> +
>> +static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>> +		struct nvme_dhchap_queue_context *chap)
>> +{
>> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
>> +	u8 buf[4], *challenge = chap->c1;
>> +	int ret;
>> +
>> +	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
>> +		__func__, chap->qid, chap->s1, chap->transaction);
>> +
>> +	if (!chap->host_response) {
>> +		chap->host_response = nvme_auth_transform_key(ctrl->host_key,
>> +						ctrl->opts->host->nqn);
>> +		if (IS_ERR(chap->host_response)) {
>> +			ret = PTR_ERR(chap->host_response);
>> +			chap->host_response = NULL;
>> +			return ret;
>> +		}
>> +	} else {
>> +		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
>> +			__func__, chap->qid);
>> +	}
>> +
>> +	ret = crypto_shash_setkey(chap->shash_tfm,
>> +			chap->host_response, ctrl->host_key->len);
>> +	if (ret) {
>> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>> +			 chap->qid, ret);
>> +		goto out;
>> +	}
>> +
>> +	shash->tfm = chap->shash_tfm;
>> +	ret = crypto_shash_init(shash);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, challenge, chap->hash_len);
>> +	if (ret)
>> +		goto out;
>> +	put_unaligned_le32(chap->s1, buf);
>> +	ret = crypto_shash_update(shash, buf, 4);
>> +	if (ret)
>> +		goto out;
>> +	put_unaligned_le16(chap->transaction, buf);
>> +	ret = crypto_shash_update(shash, buf, 2);
>> +	if (ret)
>> +		goto out;
>> +	memset(buf, 0, sizeof(buf));
>> +	ret = crypto_shash_update(shash, buf, 1);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, "HostHost", 8);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
>> +				  strlen(ctrl->opts->host->nqn));
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, buf, 1);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
>> +			    strlen(ctrl->opts->subsysnqn));
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_final(shash, chap->response);
>> +out:
>> +	if (challenge != chap->c1)
>> +		kfree(challenge);
>> +	return ret;
>> +}
>> +
>> +static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
>> +		struct nvme_dhchap_queue_context *chap)
>> +{
>> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
>> +	u8 *ctrl_response;
>> +	u8 buf[4], *challenge = chap->c2;
>> +	int ret;
>> +
>> +	ctrl_response = nvme_auth_transform_key(ctrl->ctrl_key,
>> +				ctrl->opts->subsysnqn);
>> +	if (IS_ERR(ctrl_response)) {
>> +		ret = PTR_ERR(ctrl_response);
>> +		return ret;
>> +	}
>> +	ret = crypto_shash_setkey(chap->shash_tfm,
>> +			ctrl_response, ctrl->ctrl_key->len);
>> +	if (ret) {
>> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
>> +			 chap->qid, ret);
>> +		goto out;
>> +	}
>> +
>> +	dev_dbg(ctrl->device, "%s: qid %d ctrl response seq %u transaction %d\n",
>> +		__func__, chap->qid, chap->s2, chap->transaction);
>> +	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
>> +		__func__, chap->qid, (int)chap->hash_len, challenge);
>> +	dev_dbg(ctrl->device, "%s: qid %d subsysnqn %s\n",
>> +		__func__, chap->qid, ctrl->opts->subsysnqn);
>> +	dev_dbg(ctrl->device, "%s: qid %d hostnqn %s\n",
>> +		__func__, chap->qid, ctrl->opts->host->nqn);
>> +	shash->tfm = chap->shash_tfm;
>> +	ret = crypto_shash_init(shash);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, challenge, chap->hash_len);
>> +	if (ret)
>> +		goto out;
>> +	put_unaligned_le32(chap->s2, buf);
>> +	ret = crypto_shash_update(shash, buf, 4);
>> +	if (ret)
>> +		goto out;
>> +	put_unaligned_le16(chap->transaction, buf);
>> +	ret = crypto_shash_update(shash, buf, 2);
>> +	if (ret)
>> +		goto out;
>> +	memset(buf, 0, 4);
>> +	ret = crypto_shash_update(shash, buf, 1);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, "Controller", 10);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
>> +				  strlen(ctrl->opts->subsysnqn));
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, buf, 1);
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
>> +				  strlen(ctrl->opts->host->nqn));
>> +	if (ret)
>> +		goto out;
>> +	ret = crypto_shash_final(shash, chap->response);
>> +out:
>> +	if (challenge != chap->c2)
>> +		kfree(challenge);
>> +	return ret;
>> +}
>> +
>> +int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
>> +{
>> +	struct nvme_dhchap_key *key;
>> +	u8 key_hash;
>> +
>> +	if (!secret) {
>> +		*ret_key = NULL;
>> +		return 0;
>> +	}
>> +
>> +	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
>> +		return -EINVAL;
>> +
>> +	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
>> +	key = nvme_auth_extract_key(secret + 10, key_hash);
>> +	if (IS_ERR(key)) {
>> +		return PTR_ERR(key);
>> +	}
>> +
>> +	*ret_key = key;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
>> +
>> +static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
>> +{
>> +	chap->status = 0;
>> +	chap->error = 0;
>> +	chap->s1 = 0;
>> +	chap->s2 = 0;
>> +	chap->transaction = 0;
>> +	memset(chap->c1, 0, sizeof(chap->c1));
>> +	memset(chap->c2, 0, sizeof(chap->c2));
>> +}
>> +
>> +static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
>> +{
>> +	__nvme_auth_reset(chap);
>> +	if (chap->shash_tfm)
>> +		crypto_free_shash(chap->shash_tfm);
>> +	kfree_sensitive(chap->host_response);
>> +	kfree(chap->buf);
>> +	kfree(chap);
>> +}
>> +
>> +static void __nvme_auth_work(struct work_struct *work)
>> +{
>> +	struct nvme_dhchap_queue_context *chap =
>> +		container_of(work, struct nvme_dhchap_queue_context, auth_work);
>> +	struct nvme_ctrl *ctrl = chap->ctrl;
>> +	size_t tl;
>> +	int ret = 0;
>> +
>> +	chap->transaction = ctrl->transaction++;
>> +
>> +	/* DH-HMAC-CHAP Step 1: send negotiate */
>> +	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
>> +		__func__, chap->qid);
>> +	ret = nvme_auth_set_dhchap_negotiate_data(ctrl, chap);
>> +	if (ret < 0) {
>> +		chap->error = ret;
>> +		return;
>> +	}
>> +	tl = ret;
>> +	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
>> +	if (ret) {
>> +		chap->error = ret;
>> +		return;
>> +	}
>> +
>> +	/* DH-HMAC-CHAP Step 2: receive challenge */
>> +	dev_dbg(ctrl->device, "%s: qid %d receive challenge\n",
>> +		__func__, chap->qid);
>> +
>> +	memset(chap->buf, 0, chap->buf_size);
>> +	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
>> +	if (ret) {
>> +		dev_warn(ctrl->device,
>> +			 "qid %d failed to receive challenge, %s %d\n",
>> +			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
>> +		chap->error = ret;
>> +		return;
>> +	}
>> +	ret = nvme_auth_receive_validate(ctrl, chap->qid, chap->buf, chap->transaction,
>> +					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
>> +	if (ret) {
>> +		chap->status = ret;
>> +		chap->error = NVME_SC_AUTH_REQUIRED;
>> +		return;
>> +	}
>> +
>> +	ret = nvme_auth_process_dhchap_challenge(ctrl, chap);
>> +	if (ret) {
>> +		/* Invalid challenge parameters */
>> +		goto fail2;
>> +	}
>> +
>> +	dev_dbg(ctrl->device, "%s: qid %d host response\n",
>> +		__func__, chap->qid);
>> +	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
>> +	if (ret)
>> +		goto fail2;
>> +
>> +	/* DH-HMAC-CHAP Step 3: send reply */
>> +	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
>> +		__func__, chap->qid);
>> +	ret = nvme_auth_set_dhchap_reply_data(ctrl, chap);
>> +	if (ret < 0)
>> +		goto fail2;
>> +
>> +	tl = ret;
>> +	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
>> +	if (ret)
>> +		goto fail2;
>> +
>> +	/* DH-HMAC-CHAP Step 4: receive success1 */
>> +	dev_dbg(ctrl->device, "%s: qid %d receive success1\n",
>> +		__func__, chap->qid);
>> +
>> +	memset(chap->buf, 0, chap->buf_size);
>> +	ret = nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, false);
>> +	if (ret) {
>> +		dev_warn(ctrl->device,
>> +			 "qid %d failed to receive success1, %s %d\n",
>> +			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
>> +		chap->error = ret;
>> +		return;
>> +	}
>> +	ret = nvme_auth_receive_validate(ctrl, chap->qid,
>> +					 chap->buf, chap->transaction,
>> +					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
>> +	if (ret) {
>> +		chap->status = ret;
>> +		chap->error = NVME_SC_AUTH_REQUIRED;
>> +		return;
>> +	}
>> +
>> +	if (ctrl->opts->dhchap_ctrl_secret) {
>> +		dev_dbg(ctrl->device,
>> +			"%s: qid %d controller response\n",
>> +			__func__, chap->qid);
>> +		ret = nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
>> +		if (ret) {
>> +			chap->error = ret;
>> +			goto fail2;
>> +		}
>> +	}
>> +
>> +	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
>> +	if (ret) {
>> +		/* Controller authentication failed */
>> +		chap->error = NVME_SC_AUTH_REQUIRED;
>> +		goto fail2;
>> +	}
>> +
>> +	/* DH-HMAC-CHAP Step 5: send success2 */
>> +	dev_dbg(ctrl->device, "%s: qid %d send success2\n",
>> +		__func__, chap->qid);
>> +	tl = nvme_auth_set_dhchap_success2_data(ctrl, chap);
> 
> Host should send DH-HMAC-CHAP_Success2 message only if it requested
> bidirectional authentication and that authentication succeeded.
> 
Indeed. Will be fixing it in the next submission.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

