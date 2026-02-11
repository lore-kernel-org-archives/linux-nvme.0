Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4A1EB594B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 01:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:In-Reply-To:Content-Type:Date:To:References:Cc:
	Message-Id:Mime-Version:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UG0mqORVxhaZ0a+OZCSMkiGFaCvU9+2moAIWtkDvylc=; b=Taq4PQxWjL4aPOfGDlnEAO7oWn
	22bF4KN+yj7oCVNbwdeu4OerXbZ0/W7vns+X0gao3bSMusBsbQ+9/W4LWc/DFKmsSpUoc2rd0s1K2
	9huMqq+eGevuuakDk9sk6vzH+d5EYxIbgsylndhO0xfNOmCPoEzCyW+L2g/V+n7aG/Db1/3LKE9+O
	Zikwpz8/IgBhApJU75MqlQOeB3fciw4dT1na6EQRabGpXEORjvHkmfq4rfvdNJ2sNE3NWFOpi3m9U
	4gYzScf+Ho5xDWvcIOodWfcuBq1zLm9h2X35NUBwccWoD2jFs5cihWyLk3+XIDA98S2eWl1Q0WGCA
	DS1eTh1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzUA-000000006tA-1IbR;
	Wed, 11 Feb 2026 01:57:46 +0000
Received: from sg-1-14.ptr.blmpb.com ([118.26.132.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzU5-000000006ro-3yBQ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 01:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770775051;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=UG0mqORVxhaZ0a+OZCSMkiGFaCvU9+2moAIWtkDvylc=;
 b=vqp1JWRc8DOOZsP7AMzTytrnJyLG3LxiYQvOCDXL8S8Zb2UyLbuelVmjdfEHw4rJmjh5Lw
 8yYPelvrgUqQ/0l0gVK7TwqzLW6ySaPA3UjkHuBYcGMnBent6iPSF7/kbx/xLHR2w+WOnn
 UJpl1oGmnS56WXR6Spe6k2AB85Vb986jt5z9tPLi8QJt3b4cu6pt8VI4eLNoWIWyGyOfDG
 ua//Fq2A0iK4KMG1EUDp5c3ZokUjCqCiUCK28eNBgkhlKE3ZMWaYrQKxf8AJqNPaJ1hgU7
 jpVNbJ4GusObE2vYHKWBLvYLQgnqTgMC4dwULqc+2SDF7x6gzO92TdOfBtb3ew==
From: "Yu Kuai" <yukuai@fnnas.com>
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Wed, 11 Feb 2026 09:57:28 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Lms-Return-Path: <lba+2698be209+5d2abc+lists.infradead.org+yukuai@fnnas.com>
Message-Id: <baa254f9-c41c-44f7-959a-8ce69e1768fa@fnnas.com>
Cc: "Christoph Hellwig" <hch@lst.de>, <axboe@kernel.dk>, <sagi@grimberg.me>, 
	<sven@kernel.org>, <j@jannau.net>, <linux-block@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>, <neal@gompa.dev>, <asahi@lists.linux.dev>, 
	<linux-arm-kernel@lists.infradead.org>, <yukuai@fnnas.com>
Content-Language: en-US
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-4-yukuai@fnnas.com> <20260209145832.GC18315@lst.de> <aYn-xwFHCpd7sITJ@kbusch-mbp> <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com> <aYtKFNm-wRKn6l66@kbusch-mbp> <20260210154108.GB2484@lst.de> <aYtWSscg6L9xxlzc@kbusch-mbp> <f3451ddd-96b6-4bc1-9d4c-964e361d56fc@flourine.local>
To: "Daniel Wagner" <dwagner@suse.de>, "Keith Busch" <kbusch@kernel.org>
Date: Wed, 11 Feb 2026 09:57:26 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <f3451ddd-96b6-4bc1-9d4c-964e361d56fc@flourine.local>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after nvme_unfreeze
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_175742_153796_B551BF25 
X-CRM114-Status: GOOD (  13.20  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/2/11 0:28, Daniel Wagner =E5=86=99=E9=81=93:
> On Tue, Feb 10, 2026 at 09:01:14AM -0700, Keith Busch wrote:
>> On Tue, Feb 10, 2026 at 04:41:08PM +0100, Christoph Hellwig wrote:
>>> On Tue, Feb 10, 2026 at 08:09:08AM -0700, Keith Busch wrote:
>>>> If you leave the queue quiesced, pending IO will form requests that ar=
e
>>>> entered and waiting in the block layer. You can't freeze a queue with
>>>> entered requests.
>>>>
>>>> We unquiesce first to flush any pending IO that had entered during the
>>>> prior reset. It's not the best way to handle this situation. It would =
be
>>>> smarter to steal the bio's from all the entered requests, then end tho=
se
>>>> requests, then resubmit the bios after the hw queues are initialized. =
We
>>>> don't do that because no one's really complained, probably because the
>>>> queue counts don't usually change after a reset.
>>> FYI, Daniel Wagner had been thinking about doing this reinsert for
>>> something (I forgot what exactly),
> This feature would solve a tricky problem with isolation patches:
>
> https://lore.kernel.org/linux-nvme/87cy7vrbc4.ffs@tglx/
>
> Currently, it's not possible to take the cpu hotplug lock which would
> prevent races in the cpu-queue mapping. The current logic depends on
> making progress in the error case. If it would be possible to fail the
> in-flight request in the error handler and reinsert them in the block
> layer, progress could be guaranteed when holding the cpu hotplug lock.
>
> Unfortunatly, haven't found time to implement and test this idea so far.
> Sorry.

Thanks all!

If I understand this correctly, it seems fine to make progress with this se=
t,
currently IO can return error during the race window, and this can be final=
ly
fixed with this reinsert.

--=20
Thansk,
Kuai

