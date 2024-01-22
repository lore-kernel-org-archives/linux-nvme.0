Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE5AC47DD9
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fGZ8UrGIA6ofn93uwJPrAf4ywr/8t1r3mOvfKEvvesQ=; b=QR8eKELBim42Eo7CVI/6O7lcEM
	DY/qrzzfDEkCyGBiBvlWjakIq8+w0yfrGxQ8pZOpf/ZsrlCHYNMDL0EcZ4nX8XcVszVPutk+i3zrv
	1P9Jyj1wYg9XY8ofCc7PB8YPORrsqa/EIFRjHH3T2Ga8MHIYV8n53/+HRB3AhOusm9F/EC0FaL/yZ
	cW/dJoPCaCGIlSaijA/KXfLzAyY0wGk3Pvmr0CG/E5rlYJ0ePBC/nTSunSINp4VlQiCawAq19kdL/
	lIZ+2yDVbwMnWqaB6Gh3zDEgqtS+S/z6TVov17baPpq1a5uisVHgYhOv/ckIi+2wLw/DA/BHe8UVj
	Je/SL7jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwiL-00CqKu-0R;
	Mon, 22 Jan 2024 15:59:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwiK-00CqKW-0H
	for linux-nvme@bombadil.infradead.org;
	Mon, 22 Jan 2024 15:59:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=fGZ8UrGIA6ofn93uwJPrAf4ywr/8t1r3mOvfKEvvesQ=; b=nC0Jv1OsXTXbCyvARga6ELXgKv
	hmj8qMDC73DDN8sA0jKUFA1sqp5WbShjszwznlI/FZMQ0aKtVIhwMonmmUNzMFVg5QoALeCXZQnqS
	Vn+s4k5OrXASPFk2ImZM4PcDMySz2XUl/jojxToLsHR6SW5MwqP9SDABeIFrBpav1JPfbBOO+yf5Z
	RV4wq7yDCi7Vao4C2vy/yrU+nNTae/C6HQutgqESixUb9qdIIKnMrAKIntkGsQPNGe4LJWPkltWD6
	n8tzBKucea4Yt7g9RqOgkRmsJtgZVu3TvU99UMG7Ln/IBNme3wKhxMCcfderyqj7VbJoV6wUQfVP/
	6M2/FVeg==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.14])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRwiH-00000000LBf-0Mri
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:59:54 +0000
Message-ID: <bc33203e-3ba6-497a-9417-7a1b545035f5@grimberg.me>
Date: Mon, 22 Jan 2024 17:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
References: <20240122154712.1235940-1-sagi@grimberg.me>
In-Reply-To: <20240122154712.1235940-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/22/24 17:47, Sagi Grimberg wrote:
> Test test test
> 

Another test (sorry for the spam)

