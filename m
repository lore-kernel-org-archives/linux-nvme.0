Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E956C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 06:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xAh02prDjnFxQ1U5wT6jnHqSiUp74VxzEkZzO8lmmgU=; b=jvA1yKLglT177cXs2Y3St7AKP8
	Y7ByYjquDNzmI9oW928l68Tof/VlvnBaEDdQBfzmRUujaVzRSu1zsKs9pex0OgkbKiFtNBwnxG2hG
	Jk6Pg+XwHjiQAlhBgdjfwPM3HhLN8NxdY5FgBrSTR4RxFWhqmlVw7GmV75qAU46AX/lj13eLXCXD9
	cSZR0i/oO28McyazJ3R87yO/UeZnPMjQPEwRPRMMXwWILfO7fxTPvRSv4lH4wKo093DUjKtqDr5DW
	/Zk+Pum/iwP4/79cEzE3ycn1I1W1Frxz7WJA2BFEsbmn6s5Yd4gNX6Fka4EmyQLPvQt/nIR5wBMve
	wGZ6XDqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npOmo-00Eh2X-61; Fri, 13 May 2022 06:28:26 +0000
Received: from mout-u-107.mailbox.org ([91.198.250.252])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npOml-00Eh19-Bb
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 06:28:24 +0000
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Kzz3W2L6Hz9sQv;
 Fri, 13 May 2022 08:18:15 +0200 (CEST)
Message-ID: <c0152ba1-302d-9d25-fb59-6d2a4924db8a@denx.de>
Date: Fri, 13 May 2022 08:18:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: Harden drive presence detect in
 nvme_dev_disable()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
References: <20220506101534.1728011-1-sr@denx.de>
 <7fc45981-6f12-4cb2-9eb1-f18cfa69d0df@nvidia.com>
 <Yn0anJBHcSd1K2tM@kbusch-mbp.dhcp.thefacebook.com>
 <60ba95d4-ca30-546f-b179-52cd5be7e82f@nvidia.com>
 <Yn27q2sh6FiOFEDb@kbusch-mbp.dhcp.thefacebook.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <Yn27q2sh6FiOFEDb@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Kzz3W2L6Hz9sQv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_232823_575180_4C3D42DE 
X-CRM114-Status: GOOD (  22.73  )
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

On 13.05.22 04:00, Keith Busch wrote:
> On Fri, May 13, 2022 at 04:07:18AM +0300, Max Gurtovoy wrote:
>> On 5/12/2022 5:33 PM, Keith Busch wrote:
>>> It might happen if the device requires a Subsystem Reset to activate the new
>>> firmware.
>>
>> but isn't the reset something that the admin should do ?
>>
>> some power-cycle or cold-reboot or other reset.
>>
>> In the reported case the device resets itself. I'm not sure it's expected.
> 
> I'm not familiar with this device or the procedure used to update the firmware,
> but I'm aware many vendors still provide their firmware bundled within their
> own tooling, so simply running that utility could do all sorts of things
> including a device link reset.

We are using standard nvme-cli tools for the FW update process, like:
nvme fw-download ...
nvme fw-commit ...

> If the device is resetting itself without a user or driver app initiating it,
> though, that would be bad behavior outside the spec. But if this harmless patch
> improves interop regardless of device behavior, then it should be okay to
> include.

Yes. The device resetting itself seems to be outside of the spec. Still
we somehow need to handle this situation.

>> BTW, for sure the fix is good for the hot unplug case but FW reset shouldn't
>> cause this scenario IMO.
> 
> Yeah, the patch is fine as far as I'm concerned, though it is impossible to
> prevent all register reads executing concurrently with any random link-down
> event. The commit log indicates reading registers during such an event causes a
> kernel crash, so a more complete fix probably needs to come from the platform
> level.

Agreed. Even with this patch applied, we have still seen Kernel crashes
after the "nvme fw-commit", when the drive reset'ed itself twice (IIRC).
We were able to work around these issues by removing the nvme modules
exactly when the PCIe device was removed (via HP event) for now.

Thanks,
Stefan

