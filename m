Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81127CD3436
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/7GDJHfoZama8Rs4rr22Ak1/hsgooqE6nFKAt4bVOQ=; b=i8yR0ztvXkPx2DjBhTa9RPGdln
	uSmE951e7E3FdKt6TbH5LgrqTkBtvCNWEsn+jEYrRyOvQDNr3H67LASIT4KJmlZvQ5hsGHK7ZgZVp
	vZI2CdBGVirPBKoFIQrawMqNApIFn19ag4jZFOrkODPV7OKACYHVM/OvPfQVoavuXlXz098vuOyUz
	snTsu8wX8FRGGOqowDG9ao5cjiCGcQO5P0o2gN+KKrUSNArrBgE6P/3Q/SpB+qixz7JNp7o2LOptS
	EiHVCU9KqowQT46jzC2oMhTTvJDBISzRh+eXiop3uqwz+TEfXNp5B91DiUIhYwB+8kOgT3Vbreba5
	wXaod+Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLETk-00000005i1C-0qne;
	Fri, 08 May 2026 06:14:28 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLETg-00000005hzX-3n3j
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 06:14:26 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 1dc60b72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 May 2026 08:14:19 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 08:14:18 +0200
Message-Id: <DID2OOTHHCJK.2XDEYLZJ0REYA@arkamax.eu>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>,
 <mkhalfella@purestorage.com>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during
 reset
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@arkamax.eu>, "Maurizio Lombardi" <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-8-mlombard@redhat.com>
 <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
 <DI4QV80PTNP9.1ZY7L7GFJ8TX5@arkamax.eu>
 <b0e028bb-839a-476d-a640-690a301bd8f6@suse.de>
In-Reply-To: <b0e028bb-839a-476d-a640-690a301bd8f6@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_231425_271932_00CA83F7 
X-CRM114-Status: GOOD (  11.33  )
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

On Thu May 7, 2026 at 6:23 PM CEST, Daniel Wagner wrote:
> Hi Maurizio,
>
> On 4/28/26 1:17 PM, Maurizio Lombardi wrote:
>> It would be something like this (just a compile tested draft,
>> I still need to properly test it, but it should give you an idea):
>>=20
>>=20
>> nvmet-loop: do not alloc admin tag set during reset
>>=20
>> Currently, resetting a loopback controller unconditionally invokes
>> nvme_alloc_admin_tag_set() inside nvme_loop_configure_admin_queue().
>> Doing so drops the old queue and allocates a new one. Consequently,
>> this reverts the admin queue's timeout (q->rq_timeout) back to the
>> module default (NVME_ADMIN_TIMEOUT), completely wiping out any custom
>> timeout values the user may have configured via sysfs and potentially
>> racing against the sysfs nvme_admin_timeout_store() function
>> that may dereference the admin_q pointer during the RESETTING state.
>>=20
>> Decouple the admin tag set lifecycle from the admin queue
>> configuration and destruction paths, which are executed during resets;
>> Specifically:
>>=20
>> * Move nvme_alloc_admin_tag_set() into nvme_loop_create_ctrl() so it
>>    is only allocated once during the initial controller creation.
>>=20
>> * Defer the destruction of the admin tag set to
>>    nvme_loop_delete_ctrl_host(), the terminal error-handling
>>    paths of nvme_loop_reset_ctrl_work() and
>>    nvme_loop_create_ctrl().
>
> This looks way better IMO. So yes please, add use this version.

Sure, I will post a new version very soon.

Maurizio

