Return-Path: <SRS0=DhF7=6T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E35C47254
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2020 10:24:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBAC20675
	for <linux-nvme@archiver.kernel.org>; Tue,  5 May 2020 10:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h+lzVVOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBAC20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0Oz/PXhEY9BaX/JRXswdfo9/q8v9Odd89SEicTkDRRo=; b=h+lzVVObzI7/z1
	s3LBww2EBS6nQRvQ2BbFr2OWKYR67vd2ZrEc6l3muVT0NOKQkrDwglqwyy2/xsJsAOFsFroljqBoD
	erNq2hKg9AHHcEo8JrFm2GlFjOScrCKR0yiSqLk4g7re8nqwsyha0q1IKatS9R991aOeGetPRN3Dh
	2NDXoFh/mJLm+SkJLFYY74Mfie/pti2lNmAvsmIjz9iSmCPshdUwoIPS4OH3MoDWflmaEVbTZ8QGh
	k1nPjYjbOuV7dIdcT3CBhARqAonN0f6V17pLbR+WrKls2yeA1xmreawFOPw8VXu6fYl7yVMRTuZMe
	AOoNw1SCZ7cukvn1q4cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVuk4-0002xh-4Y; Tue, 05 May 2020 10:24:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVuk1-0002xG-LJ
 for linux-nvme@lists.infradead.org; Tue, 05 May 2020 10:23:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AA65368C65; Tue,  5 May 2020 12:23:55 +0200 (CEST)
Date: Tue, 5 May 2020 12:23:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE
 when we have more to send
Message-ID: <20200505102354.GB15038@lst.de>
References: <20200505052002.14924-1-sagi@grimberg.me>
 <20200505060907.GA3995@lst.de>
 <f0f28e18-c432-8343-f7a7-79cb3159b43c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0f28e18-c432-8343-f7a7-79cb3159b43c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200505_032357_850093_248F0375 
X-CRM114-Status: GOOD (  13.92  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Mark Wunderlich <mark.wunderlich@intel.com>,
 Anil Vasudevan <anil.vasudevan@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 04, 2020 at 11:50:57PM -0700, Sagi Grimberg wrote:
>
>>> We can signal the stack that this is not the last page coming and the
>>> stack can build a larger tso segment, so go ahead and use it.
>>
>> Maybe you wan a little helper that returns the flags based on a last
>> flag?  Something like:
>>
>> static int nvme_tcp_msg_flags(bool last_page)
>> {
>> 	if (last_page)
>> 		return MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST;
>> 	return MSG_DONTWAIT | MSG_EOR;
>> }
>
> You have it reversed, the flag here probably means more...
>
> Let me see if it is useful to have, will let you know...
>
>>
>> or do we have a case where we don't want to set EOR?  At least the
>> target seems to currently have such a case.
>
> As a design goal, we try to tell the stack explicitly if we have more
> to send and if not we want to push it down to reduce latency. So
> I think we need to have it in the target as well.

What I mean is that nvmet_try_send_data and nvmet_try_send_ddgst may set
neither MS_MORE nor MSG_EOR.  Is that intentional?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
