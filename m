Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1347BC5472E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ky1WtZTB1vAFitwSZSr9oE2Lkfv8g9tc5SCDtUd5Igw=; b=XCP5eRb2OQXbtqFdSAu9F8vgvN
	QUp5G9PTImHSIoRpbcIau/n8iUnnHd1/1K+FcAkSl2NBaj1kxpYHDZFVamAIP5FJhi+SLgTAVMhLh
	GGsjgxmMbM4tklwqU6CsXo8B7N3VGPGmYdPyUhlnhe+ut9koBMskbQblqdP/LSfR59MIhVUk5LZkJ
	y8Z1eJ3MIGY+uuj/bhlSOs9XXJ5jLVeb5AUqgDTxg3N90NW8//x29LuRZHf52OqzrPEgqjZoWSP5V
	al5z2PQz7JCBSG75+INahSvNDrEDH+Hoxf9lrMW6ENDT8Xekx0AHD7T/cKC0wP/HEwgej9Fe9ByZz
	MtYGKGLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sieiT-00000008OXx-0Gnw;
	Mon, 26 Aug 2024 18:45:25 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidlD-00000008H6I-0mgZ
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 17:44:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wsyj54Rwmz6ClY9F;
	Mon, 26 Aug 2024 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724694244; x=1727286245; bh=Ky1WtZTB1vAFitwSZSr9oE2L
	kfv8g9tc5SCDtUd5Igw=; b=h8BmHZmwBPtHY/5huyweT7LC/hAMCyRbF8I/nDUc
	eInWFOIaDBLKsf8lBA747JuClgmy4aunEUTem/G+Zb1CBh1IASDyPUTvkMLdO9+X
	qf9Im9LfJJDOPEtLBbARVpojuH0XyhSxuH+s1pxtSSbzb0ndrXh6q9dJydWXuOEf
	9bkLSmmHa0O14/T+VRXR3GRbmD3jhZEV7dDoa8tyenLHf80v0Pa1BDJnwxoLR7YF
	vRgyjI5dlCOoXvve3MUZyzxLD0S6dzNucYTg+phQSn2J5HNK6zgcaHT7GQr3m8oI
	ZBY8H2kdtb4aZJ1oadDKSG/M5XNQpbawLnms14gmqV/TJw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TfuIq-julCUO; Mon, 26 Aug 2024 17:44:04 +0000 (UTC)
Received: from [172.31.110.201] (unknown [216.9.110.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wsyhx6Vmgz6ClY98;
	Mon, 26 Aug 2024 17:44:01 +0000 (UTC)
Message-ID: <d0e017ac-8367-4bb8-9b7f-d72dd068fdb1@acm.org>
Date: Mon, 26 Aug 2024 10:44:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] fs, block: refactor enum rw_hint
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org, jack@suse.cz,
 jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
 javier.gonz@samsung.com
References: <20240826170606.255718-1-joshi.k@samsung.com>
 <CGME20240826171413epcas5p3f62c2cc57b50d6df8fa66af5fe5996c5@epcas5p3.samsung.com>
 <20240826170606.255718-2-joshi.k@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240826170606.255718-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_104411_279927_B2DE2BBB 
X-CRM114-Status: UNSURE (   7.76  )
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

On 8/26/24 10:06 AM, Kanchan Joshi wrote:
> Change i_write_hint (in inode), bi_write_hint (in bio) and write_hint
> (in request) to use u8 data-type rather than this enum.

That sounds fishy to me. Why to increase the size of this enum? Why to
reduce the ability of the compiler to perform type checking? I think
this needs to be motivated clearly in the patch description.

Bart.

