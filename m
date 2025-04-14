Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC3C3601E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 07:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DhkEdAqtQqF1PUonIzfsefD+11Figh+0F2JFgGGObM=; b=PxXcXHvMqMQfXMC6XQ2ZUbi6JV
	koUhmUDr7tdVMLgoGcjKPRDHxFhNn7x7ODK4zdVgyoBW8L3FRFNZxkI28hKWbzQ2RjVKo5ti7Sxeq
	5NauH5ilMUe4N35I+ylhxWKG4HibZiU3PaItfkIdStBVGpDQ60tgxucPQDoJ07ECpeF6+39ZaX6Ek
	xHK8fectpQjOqqpDayxyeTgvuV9ELfZGrNzALRu/aa4nEe5lliCXQWETiSlQNRqXjhiQsaJeLMmoR
	Mg4oHfse8OQuQjfTj6Yr8Sb2v8yIhAQe20en7piqUj4JTaE3t00qOV45pUwc0dh+18AXjX5PemeWu
	WjJOwZ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ECD-00000000v9S-3991;
	Mon, 14 Apr 2025 07:25:33 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ECA-00000000v8y-2w2T
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 07:25:32 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 4e69d0a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 09:25:26 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Apr 2025 09:25:25 +0200
Message-Id: <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
Cc: <hare@kernel.org>, <linux-nvme@lists.infradead.org>,
 <zhang.guanghui@cestc.cn>, <loberman@redhat.com>
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@meta.com>
X-Mailer: aerc
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
In-Reply-To: <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_002531_075784_00D48B5D 
X-CRM114-Status: GOOD (  16.22  )
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

On Mon Apr 14, 2025 at 12:44 AM CEST, Sagi Grimberg wrote:
>
>
> On 04/04/2025 11:28, Maurizio Lombardi wrote:
>> There is a potential race condition that can occur if
>> the target closes the socket while the host is in the CONNECTING state.
>>
>> If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
>> function is invoked. However, nvme_tcp_error_recovery() is unable
>> to transition the controller state to NVME_CTRL_RESETTING because
>> the controller is still in the CONNECTING state. As a result, error
>> recovery is bypassed, and the controller incorrectly transitions
>> to the LIVE state with closed sockets.
>
> I think that the issue is that the controller moves to LIVE state - it=20
> shouldn't.
> However its not clear where this happens.
>
>>
>> Subsequent attempts by the host to communicate with the target
>> will result in an infinite loop.
>>
>> Fix the bug by initiating the error recovery process to correctly
>> handle the disconnection in case we missed this event
>> while transitioning from CONNECTING to LIVE.
>
> The problem is in the initial connect - here there is no error recovery
> and we want to propagate the error to the user.

Maybe there are other problems that I've not found, but this race
condition definitely exists.
This can be reproduced by deleting the port, target-side, with nvmetcli
just after the connection has been estabilished, before the controller
goes LIVE.
Yes, it's quite hard to hit it in practice, but if you want to see it
yourself, a small sleep in the right place in the host driver will
help you.

Maurizio


