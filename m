Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8439DC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L11Y+Ofq9vDBIpmzTbaZSM/N3e+aQGtfiXe/e3PirtI=; b=C+FmeLn8Q39nnnajEubiWh0dND
	VhAeOvCXT+eGkzBZfseXYuGFmfBj9H6XTYONu8CoN97r3X3dcm9T0OsLe1EZPgoi4HLVEUuTtnbqN
	ROTYPA+iF76wbTKUnZfXcLyZ6YGM/eSiQpGM2s0058hGtxvfipDACUlQQNjMyhJvnVkIYzNlAkDYz
	wmzkzkoKPsJ1Ggkv94qMWYIem8bJDSjV9+sPfMrx6PdH3RPwo+oysK0YczYUNQwsawtGOjgpOsbwH
	8xYh8raU+NPKaDKoyp3s5tgf7cvWLqKgV5lIcN9/YnlUFzwsK+7NgFqumsBqgyFX5lRNmqto0rNzW
	rjoj2S/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn8m1-00000001evp-0WBL;
	Thu, 21 Mar 2024 03:07:21 +0000
Received: from mail-m1973182.qiye.163.com ([220.197.31.82])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn8lw-00000001eu9-2GKw
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 03:07:19 +0000
Received: from [192.168.182.216] (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6FE6A4C017F;
	Thu, 21 Mar 2024 11:06:34 +0800 (CST)
Message-ID: <d0d87635-839a-43bb-89e4-9ff853d0a878@easystack.cn>
Date: Thu, 21 Mar 2024 11:06:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn,
 Christoph Hellwig <hch@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
 <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
 <20240131062526.GA16177@lst.de>
 <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
 <68f99d6e-b79f-42a9-bb19-ece27d35dfa6@grimberg.me>
From: Jirong Feng <jirong.feng@easystack.cn>
In-Reply-To: <68f99d6e-b79f-42a9-bb19-ece27d35dfa6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUhMVk8fTEhCT00fTE1DHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8e5ef98520022ekunm6fe6a4c017f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46MCo*DzczPEpNIzoJKgwJ
	Ei4wCSFVSlVKTEpLQkJLSEJOS0hDVTMWGhIXVRESCRQVHFUdHhUcOx4aCAIIDxoYEFUYFUVZV1kS
	C1lBWUpKS1VKQ05VSkxLVUlJTFlXWQgBWUFISEtCNwY+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_200716_805915_36CD4DEA 
X-CRM114-Status: UNSURE (   8.38  )
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


> Hey Jirong,
>
> We do not yet understand if this works for Linux nvme-mpath (which 
> iirc requires a suggested host-side patch).
> Once we understand that we can take the changes to mainline.
>
My last test(native multipath) was done on kernel 4.18.0-147.3.1.el8_1, 
the result is ocassional failure.

Refer to your previous reply to my question, this time I changed the 
cntlid_min/cntlid_max range, making it single subsystem from different 
targets.
then I retested, here's the result:

1. on kernel 4.18.0-147.3.1.el8_1, the failure still occurs.
2. on kernel 6.6.0, no failure. (about 50 times)
3. on kernel 6.6.0 applying your host-side patch, no failure.

