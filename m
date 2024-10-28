Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B7D339AF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VtNXrQdHOOFnlzb2aIzwM2Na4zN1gnS0OqU181Pcf1I=; b=pdfqUYNnya3v+UzPl0OhSbmfa4
	tIn0xwEmfAvspTziKFze1qKayuxrouBB/i776uonjuyzcwaGG10fkMjC7GuM3fbHXcogE3Wf6qX7N
	SUQvOOWWXXcyIXPeaosNbCUUYIlMGOtIs+OQLMDZ4e97rqmv7aPcep3dBr/AOqi+jQj+Ba/QWUdPd
	cRm8WM8wxVQBpE4QKkMwAAnoXG5f7KpabeqCOg7qAX43HY30LEmCKHVYtw74Uup9Z5rZ9e5JN+dYn
	Javbf5yhxsom3T22fbkociwnCPCroOVqqS23yXdv/byxhBGB9I5BtqjDSCl3l/jh+P6uqyxY6P3lY
	0FnS5aqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UL9-0000000Bnfs-1tRj;
	Mon, 28 Oct 2024 18:19:43 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UL6-0000000Bnet-3boG
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:19:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XchVz68Mrz6Cnk9V;
	Mon, 28 Oct 2024 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730139576; x=1732731577; bh=VtNXrQdHOOFnlzb2aIzwM2Na
	4zN1gnS0OqU181Pcf1I=; b=IhXhtoY/1SgDTi0QzhE9RjmiQfm+Z39jRZttIwOq
	hT+Bcdq64+vgLi0whfU5lYW/CqJSTyMjL4PSRYIs0djO/62Iq/bjJqw//p3ovIFk
	EIPeL8acP/UvH5zRvh435EKgg35raOWZNga1JRGJVNmTb58QjWA2tn9ntGHEjL4w
	do/wBQ8bJvq9rOLb43avas9HxduqL6A0ZXTVbRoy5sn5keBc/ELUuOJXmFYTVGFi
	J4r39+z0o00eSQBdtfyvo4gdccge/7sUWlC+/luVl1z58XEqOOGhBJY/UjA8Tjax
	bEtqzx7H8uKroVIioVzX0IT/M1ehiYoLwWximNMBcitDtQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S6r612HWI2P6; Mon, 28 Oct 2024 18:19:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XchVs5Q8yz6Cnk9N;
	Mon, 28 Oct 2024 18:19:33 +0000 (UTC)
Message-ID: <a86cfa72-426b-46f4-83b0-b60920286223@acm.org>
Date: Mon, 28 Oct 2024 11:19:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 1/7] block: use generic u16 for write hints
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-2-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241025213645.3464331-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_111940_952197_013BBF0B 
X-CRM114-Status: UNSURE (   7.75  )
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

On 10/25/24 2:36 PM, Keith Busch wrote:
> This is still backwards compatible with lifetime hints. It just doesn't
> constrain the hints to that definition.

Since struct bio is modified, and since it is important not to increase
the size of struct bio, some comments about whether or not the size of
struct bio is affected would be welcome.

Thanks,

Bart.

