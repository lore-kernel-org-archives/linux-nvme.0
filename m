Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BBEEC110C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=By1Ioj8GbL/V6zno4RRJtTxk1Y+neGd5c2WUwPqo6t4=; b=DQVfuoLjBRyD57cVdiUdwFTzKE
	TVs7M8FJ+a1w0kD3jwQhy55Hdtf8+LNVsAw6UHLlpicOnonMnalmYsDBylRnfEpDUaXDBhkGoq7O4
	AbDnF0iQAL1Ge1aAtYirOBBGfpexHDTCKUSNyOgol8x1X+9JuvFmFJXET5b4imd5HLUkk2o5ATaxu
	DDzwfxj+yEYYwyjmR1hwMT4zFyYR53VHHb153xD1vwyHY9SKXsZkGbk6MFTVsbOCIRR96dGLeItWj
	QgHhimzzgir0Y8EpXLvE5+oBNrKPD+ID0iMxbAGA8Hkqsn0fTR82+LTc3befW75OaGnG5PrrKg3XD
	UwpXkwlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZQE-00000000jAe-32z3;
	Mon, 23 Feb 2026 17:08:38 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZQB-00000000jA6-2rDT
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:08:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKS414hq7zlh1Vk;
	Mon, 23 Feb 2026 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771866509; x=1774458510; bh=By1Ioj8GbL/V6zno4RRJtTxk
	1Y+neGd5c2WUwPqo6t4=; b=su8kXIo1EVVPqrEph4n4SLJz+IZllnLbmCMPcRRW
	zHxl9VLPCWWB7lAs/QFZXSzt+jpl1qYPIdQtgrYFZCmVKNY1WrNNdnmofyq7DeFD
	M6fimJiVVJTwBhkhCJFsK7BBvRT3IrPunQNfjIU4WPzXFFBMwKkFTNeN/anwE/jj
	Izb6OBxY00m75DfXIdnCTrok6Unii/ABlX+p9C/YSd23OHNYrUpHWZ0W9ECiMtmL
	F1FiXYAhzVPeM6vyUxVTp+MvD0NWSpYGSheNAQQ30qn5e8G0b81iOp/EEhHzTB8A
	F4eSZgZpMrTO5rvvjdSoFdq4mu1zqwUh/asrmDi6S3VzUw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Snina6HJ5Dga; Mon, 23 Feb 2026 17:08:29 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKS3q2HxZzlh1Vg;
	Mon, 23 Feb 2026 17:08:23 +0000 (UTC)
Message-ID: <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
Date: Mon, 23 Feb 2026 09:08:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Haris Iqbal <haris.iqbal@ionos.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "tytso@mit.edu" <tytso@mit.edu>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz"
 <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_090835_735277_DD0D1F8E 
X-CRM114-Status: UNSURE (   6.79  )
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

On 2/15/26 1:18 PM, Haris Iqbal wrote:
> A possible feature for blktest could be integration with something
> like virtme-ng.
> Running on VM can be versatile and fast. The run can be made parallel
> too, by spawning multiple VMs simultaneously.
Hmm ... this probably would break tests that measure performance and
also tests that modify data or reservations of a physical storage
device.

Bart.

