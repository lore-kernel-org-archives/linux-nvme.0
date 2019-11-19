Return-Path: <SRS0=E+1U=ZL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3CEC432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3F021823
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sycw0Qe/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BEXmi+6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3F021823
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uqNmDp5j89IT18JJtQU6ndAxJp+obdWwFvluWsC2UBI=; b=sycw0Qe//6KlrIUUwdK7HM3XN
	nPwFo/kMCU5A9S2nzu/LQNPffQCBSpz1vpHKFY3byAFhoTvPBDnG8pvgDJ1JHKvF8TU16AZzBW7bO
	JC71x87j3H9gmNzGeakU/twSgcAlmB2T6WLr7qkSbq/4ux3+OiYmjaO4Z/TnMh2kR2HIokRcTCuWO
	w0z1TsTX+QwaWz3l9HfcN57VD8k8zGuug/QnzbaP/CU75nsU7ZlBI7H8Ij6Ia0rZtNZ9eJoV0CdaP
	HgRtBDn3WT6T/T092WgarJTKGO4c0EbdRCRvpS0Q9NoxlddwXhMsqZjz1Yy/mvZy0buhZRhpb3y2x
	fZKwkkuXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iX7kD-0002aU-5H; Tue, 19 Nov 2019 17:56:53 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iX7kB-0002Zu-7s
 for linux-nvme@lists.infradead.org; Tue, 19 Nov 2019 17:56:52 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so24961323wrx.3
 for <linux-nvme@lists.infradead.org>; Tue, 19 Nov 2019 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=wHMq7ZSXETEh3bWFK8tDMFeKTKRJwY8yw2CvHPvlDuU=;
 b=BEXmi+6OtL05WTMHqA9kU52x1sEwxJ1k4xaPQVEv5N21RR5rqdd3q7+4KHvHVWSAHJ
 5l1uOSQy+G5Lv94shjqGNgKlEMnqLIwWCLaKtoIQSoCJV+Vqwe4mzyXeK+4Kpk6ur2Aj
 ubNMsGCnQK9bH7pRKIVJ8Ly2bYQMtcjrqhxfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wHMq7ZSXETEh3bWFK8tDMFeKTKRJwY8yw2CvHPvlDuU=;
 b=rdppYHl5fxH2r6vt4uXdv+qcnoMJMs53D/gE+YtXehNLsUhaKbLlEpVBrj16CelkWj
 7gLPVIrd0nxYTzCgFi3b70iqZ5VyLnZD4qV763f7kNa9wJJpnHcNOjx1dOAUqB/YQ0e0
 +z2Cc2Rbehw4weIMV0aUa+ElSJB7KYifIoJV+Fv1DFZaTDAYPjfyIxdXNKhglR4kBZbI
 P+hHiq9yfBXdhu+HGh4fIq9TQX9nzk5XmJvXOj4x87fGQ/h5nXb1rhhoVywAHwh6bNGw
 GCmBfnNdWGp5iQBmLFbo9RFjuKqjATwTpo/sV6ck1aSWakq1tQQ98Xo0h3rEd2IQPFFN
 SfFA==
X-Gm-Message-State: APjAAAVSlhKwsXrWJHFuFE05vRb9fNDykGkZmgBv11Hbi7WsmSWe7nQJ
 fwEpZxGQr8lDHDNHg+EO3vhmcPBBdQU=
X-Google-Smtp-Source: APXvYqwTgYMrTrVFs2MZa2BfEo+k8IC9QTdLnvbdU6z2fDdUmIjIjRKD/bJa6S2+rzutNjGpTu5W3w==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr23456298wrw.126.1574186209419; 
 Tue, 19 Nov 2019 09:56:49 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q5sm3770821wmc.27.2019.11.19.09.56.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 09:56:48 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com>
Date: Tue, 19 Nov 2019 09:56:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191119_095651_287501_94637C8A 
X-CRM114-Status: GOOD (  14.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/18/2019 4:05 PM, Sagi Grimberg wrote:
>
> This is a much simpler fix that does not create this churn local to
> every driver. Also, I don't like the assumptions about tag reservations
> that the drivers is taking locally (that the connect will have tag 0
> for example). All this makes this look like a hack.

Agree with Sagi on this last statement. When I reviewed the patch, it =

was very non-intuitive. Why dependency on tag 0, why a queue number =

squirrelled away on this one request only. Why change the initialization =

(queue pointer) on this one specific request from its hctx and so on. =

For someone without the history, ugly.

>
> I'm starting to think we maybe need to get the connect out of the block
> layer execution if its such a big problem... Its a real shame if that is
> the case...

Yep. This is starting to be another case of perhaps I should be changing =

nvme-fc's blk-mq hctx to nvme queue relationship in a different manner.=A0 =

I'm having a very hard time with all the queue resources today's policy =

is wasting on targets.

-- james



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
