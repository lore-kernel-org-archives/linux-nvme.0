Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D660CA5FDD
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/UYIospwFRvaHAndMVRzyTf5yTdHhAMhzoOJSJBaSM4=; b=x9OgIgHn+geCGfLE4OLrtZzTvb
	T+Lg/qvjQY/wjRYtKOp1Ho1+VnydOdKMmM0EhThaGOteQq6rtTdtm2Xbb+pCoqGyhD139Kn+sVjc4
	n4lOyaStsTMooVviEbTD/4yQwJTQL0Ja8yAP65PLnbk+i4GwvtIGGV6vLquiChWCu/DZOSUqgMQt5
	JC/YCjrsJFeADV4Tdp4n9Rj0Nspm9wGuwjAYdViGhx0bYUZ5YM5HRgZH0cut6/bZyj63aF9nxoTQH
	/Y0uc1sECik1w16dXHP9e386EIUtwsszDqsKiThFEKKLAhH+DCYt8S5eLSwbQ4geVGKmvgsEptFmf
	xn4SSvmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD0d5-0000000DamL-07iL;
	Sat, 03 Oct 2026 14:22:23 +0000
Received: from mail.cyberchaos.dev ([2a0f:4ac0::3a11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD0d2-0000000Dale-3WYa
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 14:22:22 +0000
Message-ID: <a8975c9a-b0c8-41cf-90e4-a770666e975a@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791037336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UYIospwFRvaHAndMVRzyTf5yTdHhAMhzoOJSJBaSM4=;
	b=YImGM8T5OGOECKzOFIKO68P6aQwccPbmQd6wHrPhR18cnhTcQE00pjUynX4YQZMqcBoXPl
	sS3n7yOZbD6dZ+S9sZgR9Xem7x+2I261ZvZo5tJ/XFCVt53Dlarf+Wt+Zz6ceg80wsdBb1
	lja4fSOW5jZI5MroBhXHsVSlJPpmifs=
Date: Sat, 3 Oct 2026 16:22:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] nvme: do not reset controllers in NVME_CTRL_NEW state
To: Maurizio Lombardi <mlombard@arkamax.eu>,
 Yureka Lilian <yureka@cyberchaos.dev>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 dwagner@suse.de, asahi@lists.linux.dev, Sven Peter <sven@kernel.org>
References: <20260915095827.698928-1-mlombard@redhat.com>
 <94912d46-381d-4988-800a-6ef3b595233f@cyberchaos.dev>
 <DLV7F9W5HSFS.1D5WQW59ZEHEL@arkamax.eu> <DLV87HMYWE6U.BG10862VYDK@arkamax.eu>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <DLV87HMYWE6U.BG10862VYDK@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_072221_106315_BDA5A080 
X-CRM114-Status: GOOD (  10.57  )
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

On 10/3/26 15:09, Maurizio Lombardi wrote:
> On Sat Oct 3, 2026 at 2:33 PM CEST, Maurizio Lombardi wrote:
>> Thanks for reporting this,
>> it seems that nvme-apple is the only driver that still initializes the
>> controller by performing a reset directly from a NEW state.
>>
>> This should be easy to fix by moving the state to CONNECTING in
>> apple_nvme_probe, just before nvme_reset_ctrl() is called.
> Ops, this won't work, as we can enter the resetting state only when the
> controller is live.
>
> Keith, I think we have no other option but revert this patch to unbreak
> apple-nvme until I find a proper fix.
>
> Maurizio


When you eventually propose a new variant of this, I can certainly test 
it with nvme-apple.


- Yureka

