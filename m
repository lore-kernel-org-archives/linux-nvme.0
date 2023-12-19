Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E952C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu9gaNKAUT2iGvx5Wlu2dDnVW1vAzhX2ij3CtpntdTQ=; b=2Lb4Mbsg1zZGuPqJhQtNUGRPOl
	4cXQTxqulFlBNvKHIjKR+yQqP9QGymkF5q+qC3bj1IxKa+3Cvia4An7/QpW9clKn65hvpVKRTsrib
	K5M3iYCQv+1OdYfxLjV/6wCNeNaIM7GR5Gn1c/bBFW1z0J9QURB+/uufVthFElmo0hgeyTqwJtPca
	OMtCgMD2thGCWO5b8bmr0NnFoqvDyg+rjK/yaMy6LIopGmAPnYCwEEly2Pm0YxgD4UkZFuNBGyWAN
	DtmVKs7akyIpSjddx/ZpRWNjYUP32BhObJ0neUF24rlry+TGpIZ9B+V+9jJzZ4KwQ+lYCIKgyoP1F
	5bcKtAwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFTSY-00CyJm-1p;
	Tue, 19 Dec 2023 06:20:06 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFTST-00CyGj-2Z
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 06:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=vu9gaNKAUT2iGvx5Wlu2dDnVW1vAzhX2ij3CtpntdTQ=; b=eFI8HcJugBGm7tycezsyhSl0fp
	uoHQuNpWg7N6TI9tBP+cwLGFANo7dS0VnJndH7KggOwoe0eLjqr/3Pz3YtzU25lXDe0XMccp7K8Yu
	LJkGGF36SHn9TmhKKch+ywCQIYfhFoX1WeYN29IahrLQ35aTYhPCjj8Tb8FBWuGIK9YrXignyYa0W
	+hnP98cx34hVtulSF4hCpfgp+FFnmMO1qkXVkjuMgHo8np+qO08xuHuynlWS+zFrp7oKB8dgJwmee
	vKiyW6TUGyx2Oyj7gb9ww1LRQx8b9GbwlwSYws46UzOkApdzKzS9FE7KETvUzMa59lE7vU8xgQ0RD
	QPUChJ8yV7rmw6j/24vFkwQD3mw3FhO0Ei/TsxROsTrxNsOu9GIEH3b4ESafK5N/Hmj7YWmsP/fLA
	OaqOxS3VK75KMVKXZCDhjcKCZZ4fygvMXpANR95kYUJPWCRR04sFNXWWxnA62diMnh38nR+Cy+C7D
	I7C0infMO+Iyyrdd7c+PcxZv;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rFTSF-004IqU-0v;
	Tue, 19 Dec 2023 06:19:47 +0000
Date: Mon, 18 Dec 2023 22:19:43 -0800
From: Jeremy Allison <jra@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com, jra@samba.org
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Message-ID: <ZYE1/xighk0dqjIY@jeremy-HP-Z840-Workstation>
References: <20231215000358.1203338-1-jallison@ciq.com>
 <20231215000358.1203338-2-jallison@ciq.com>
 <20231219053318.GA559@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231219053318.GA559@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_222001_848182_59E51285 
X-CRM114-Status: GOOD (  15.91  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 19, 2023 at 06:33:18AM +0100, Christoph Hellwig wrote:
>On Thu, Dec 14, 2023 at 04:03:56PM -0800, Jeremy Allison wrote:
>> From: Tanjore Suresh <tansuresh@google.com>
>>
>> This changes the bus driver interface with additional entry points
>> to enable devices to implement asynchronous shutdown. The existing
>> synchronous interface to shutdown is unmodified and retained for
>> backward compatibility. shutdown_pre is only called if a matching
>> shutdown_post function is also registered, otherwise the synchronous
>> synchronous interface is used.
>>
>> This changes the common device shutdown code to enable devices to
>> participate in asynchronous shutdown implementation.
>
>Is there any reason to have a separate shutdown_pre method?
>Especially with all the method wrapping in the driver core, yet
>another method just keeps confusing everyone.

Currently in the patch the existence of a shutdown_pre() method
for a device causes it to be added to the async_shutdown_list
which is walked to reap the completion status after all the
calls to shutdown_pre().

I could change this so that the existing shutdown() method
is always called, and the device is only added to the async_shutdown_list
if a shutdown_post() (or as requested below, shutdown_wait())
method is defined for the device.

That makes sense to me and I'm happy to make that change.

>And on the post side, might shutdown_wait be a better name to
>describe the operation, but I'm open to opinions.

I'm happy to change shutdown_post() -> shudown_wait().

shutdown_pre()/post() seemed a natural fit, but if we're removing
shutdown_pre() then shudown_wait() works.

