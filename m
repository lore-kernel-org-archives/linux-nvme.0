Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DE5E7DF13
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20atEx3/P4iNMKWAlADed+bIKkDwteGSQmMERIZ+mG4=; b=IarcOPWdI8WKTR4Fg5aftEZuqw
	lFh6eSq9TobUbCm7ID4nrfHsfnM+h1MTDW9XJa0GFcoyn1fOv3jRgFPsWkY5NOXZW+FCBn+VcIoXD
	ManCQRnT2wyg2/LyRXwPosqf/3v/g9lowNIUKjDPfse9cvQNLIA9vRpy5g7vn7ihudP/u43hbncK3
	MLueNGGUnwYVZW4jUJ+hnDlIQAUxBlSVCFcriH7Gqcw8GW809sa5X/Drhn9lfILMsbjQGXi+11z64
	C+BmjESLOU+AK5gHnlYA3fEbrXZNa1Jh12ZnPSEz6INmVNR6Uv09EGHloMHcwhTuHd09Rs5JWbPSO
	rBmUFE8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxiT-00000005MOW-2Y7u;
	Mon, 02 Feb 2026 17:28:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxiR-00000005MOM-2pAJ
	for linux-nvme@bombadil.infradead.org;
	Mon, 02 Feb 2026 17:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=20atEx3/P4iNMKWAlADed+bIKkDwteGSQmMERIZ+mG4=; b=Dfqd6z6KgG8PP2pOsMja4OioLK
	gi+4P6ceils2hys9BScEBir9buDKo40ev2bin6haPQZ9BxLzZLV2lkAg1SUOsDxIg7ilcQd9yMcrJ
	XzCByzKMc/iPWQNfYyAtIjNvICQ5wYdTi66sUorofl77VO6Lsv0A8ToXagkrqNBHq8ZTD9Zk0l9ni
	WjpYMgTLfGSJOe5Mf96yFpV2QHtWDC48WIPkXMb6HS3daZ01aqu/xjbtlL+qp8cx7+HeWXHq3wRv4
	X14yr0Hoa8std9T6PASav/BLOupcHnLBefvKttaT0b2+1mSdIliJLX3fA5g+VTSUMjifGpHSzDwMK
	zSzRhgQw==;
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxiN-0000000EwHq-1cmc
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:27:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f4YTk6gKxzlfl7L;
	Mon,  2 Feb 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770053257; x=1772645258; bh=20atEx3/P4iNMKWAlADed+bI
	KkDwteGSQmMERIZ+mG4=; b=Pu8GrKsdTVHVIz9grGNIDD+gqa0JvwB75jtixH5m
	SB1lWh6VBl5okSvmVE7Dc8RzSde6YWqUpSB2AtEm20/zNfGB9WrxjOa1JVmtVkJm
	A5T8r/+SNT2gDml8CRvhsNa5sC1ejIFRJYcSioXBUkrGSK9TTeB/qI92zp5bUgCK
	ExfoEksFFWp0UKBLDuLAUVjO9fFETkTIw1JT2gUwhKot3Hc+WoUHKdZtq51Id5Ie
	a9tn6K2JcTObs5O6oGIXUwpUfP8XgKvAqzGfCCFC3gS2N8Ely1Jig1bHPmXrHUl2
	KAdjPd6XUon+E4h900Ic4/eYinqn/bcN595HXJxFTC6ukQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id p7w3W-3KAHqn; Mon,  2 Feb 2026 17:27:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f4YTh6mDxzlfvpL;
	Mon,  2 Feb 2026 17:27:36 +0000 (UTC)
Message-ID: <923b3b4d-a84e-4a19-8767-6bca59204ff1@acm.org>
Date: Mon, 2 Feb 2026 09:27:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Hannes Reinecke <hare@suse.de>, lsf-pc
 <lsf-pc@lists.linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_172755_600363_E95A74AC 
X-CRM114-Status: UNSURE (   7.62  )
X-CRM114-Notice: Please train this message.
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

On 2/1/26 9:06 AM, Hannes Reinecke wrote:
> While we could easily terminate the controller, the specification
> also requires us to terminate all outstanding commands.
What specification is the above referring to?

Regarding terminating outstanding commands, doesn't how to do this
depend on the storage protocol? Isn't the recommended procedure for
NVMe to delete and re-create all I/O submission and completion queues?
This procedure doesn't require support in the block layer for aborting
individual commands.

Thanks,

Bart.

