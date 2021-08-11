Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CCC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:08:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1169E60E93
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1169E60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BOiFMgePha5Tf9XObBI5ETqRJ4xuAu4rK1ZhIRZRcIQ=; b=eNV9qBDfohexEz
	g7O8g9huBvYPPRTeA6TJk3GwN5zrOD3W0Yq56OQ/nI/xsp16OWS4bAxKspmUj4AS8yQiJwl1qDBNM
	50D9XNfts40TJvJWVWaa8yMAXSt4YsvGqPwOq7xtgB9DoXnEFhQLFRFODglRkGwdZhSsJM4d5RVtH
	EdeSbyu6Sed1a7a1PVkqSINJr0TGTSKq65/UfXRBHZIaC+mqEte4THf1Uuj4FdbwNI3quenqnKSnU
	AVTQTT14NjVSSh8HS0g/LmSKobc9fGQ1fpt+QdnRDc3XKIQqnAZoA3Dz1OAO95jM/f5VvIjN/7SQy
	go8I54pEwzaF1Tk/lfYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDciL-0058Yu-Vh; Wed, 11 Aug 2021 01:07:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDciH-0058Xc-5U
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:07:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DAED60EE7;
 Wed, 11 Aug 2021 01:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628644040;
 bh=Kzw3EE08cLDDxpFKCb5ghCcQ8BT9rSSf34MuXPqd2js=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rkpMUw07zaqXpsN6IamkLlptJqRCTggAPkqO/kzKQN5yd9b7wECe4OB5fi0lNoRqE
 bqCVEAoTAuJf5bWouBr88yLnquj85hY/QYn/TlutxszsuF1bKui8XIqitQ3myBBzel
 mp8UzrJbehkoPX/zciSaxEyWwrwgtrAolPzV+ewDdgJwj22DRfBzVsBHMh8yl9y08g
 u8PHKj+UM5hlOeaBX3yVljGP1z313P2kVNxaSQVmG8QS7kWrk+ESFTKU3ZIjRbd/z4
 mI30XJn7GN/byHrxo+dS8KaYvCUypoOsQDQXSjQN9h8yPIfmKHQ+lAbXuU4DPUQ4a+
 d2KV7TWJLT7xg==
Date: Tue, 10 Aug 2021 18:07:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Message-ID: <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
 <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_180721_322361_42D1C7ED 
X-CRM114-Status: GOOD (  18.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 10, 2021 at 06:00:37PM -0700, Sagi Grimberg wrote:
> 
> 
> On 8/9/21 1:52 AM, Daniel Wagner wrote:
> > Hi Sagi,
> > 
> > On Fri, Aug 06, 2021 at 12:57:17PM -0700, Sagi Grimberg wrote:
> > > > -	ret = nvme_tcp_start_io_queues(ctrl);
> > > > -	if (ret)
> > > > -		goto out_cleanup_connect_q;
> > > > -
> > > > -	if (!new) {
> > > > -		nvme_start_queues(ctrl);
> > > > +	} else if (prior_q_cnt != ctrl->queue_count) {
> > > 
> > > So if the queue count did not change we don't wait to make sure
> > > the queue g_usage_counter ref made it to zero? What guarantees that it
> > > did?
> > 
> > Hmm, good point. we should always call nvme_wait_freeze_timeout()
> > for !new queues. Is this what you are implying?
> 
> I think we should always wait for the freeze to complete.

Don't the queues need to be started in order for the freeze to complete?
Any enqueued requests on the quiesced queues will never complete this
way, so the wait_freeze() will be stuck, right? If so, I think the
nvme_start_queues() was in the correct place already.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
