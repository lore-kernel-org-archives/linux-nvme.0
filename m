Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD02C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYJgALOWGMxx4b+RK+wxh0LiRLiFuqL+szhJxpi2LVA=; b=O00T+kkgjEblw6YhUjiex/rFs5
	tkvyAb7LRPEqpzzzkM76E99RvAqxfts0b+I4SHHSZdMvnZbS+H9vtpqy/+/9kiVtwdZ+wUmVm3UkW
	p23wob6K6TK25ntrOhsBJ6gjgCyNic/cabY1iqBQw9oS5i24dzaJLFRNqNTUiHTOBIjDhMj4nq7BD
	X1up7LhnhBpECaajRYX8ZUZbWa55Tle4XTrixDmMgd4Yb5IcCsO9aDdjNaqffEhmsqINGSItS10WO
	OBmtnG86d+mRWpiAqdweudycpia+Ck82KH9UzIgs0wcl8iZhBRvYAPJ5wJfztyoot1AD2Esjm7HNu
	JidIqSxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsLmi-00000008Uw0-0qgL;
	Wed, 12 Mar 2025 13:06:08 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsLBI-00000008OrU-0pmU
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 12:27:30 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 83b88c1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 13:27:19 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 13:27:17 +0100
Message-Id: <D8EACDH1T444.1J8JZ7QTY1I1J@bsdbackstore.eu>
Cc: "Sagi Grimberg" <sagi@grimberg.me>, "Christoph Hellwig" <hch@lst.de>,
 "Keith Busch" <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-tcp: sanitize request list handling
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Chris Leech" <cleech@redhat.com>,
 "Hannes Reinecke" <hare@kernel.org>
X-Mailer: aerc
References: <20250307132802.111513-1-hare@kernel.org>
 <20250307132802.111513-3-hare@kernel.org>
 <Z9CGtUqkAR6uWWs-@my-developer-toolbox-latest>
 <224d7699-abf5-4bd9-a31e-f92973b94401@suse.de>
In-Reply-To: <224d7699-abf5-4bd9-a31e-f92973b94401@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_052728_622338_D9C70F66 
X-CRM114-Status: UNSURE (   8.29  )
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

On Wed Mar 12, 2025 at 9:16 AM CET, Hannes Reinecke wrote:
> On 3/11/25 19:53, Chris Leech wrote:
>>> @@ -759,8 +762,12 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_que=
ue *queue,
>>>  =20
>>>   	nvme_tcp_setup_h2c_data_pdu(req);
>>>  =20
>>> +	WARN_ON(queue->request =3D=3D req);
>>> +	WARN_ON(llist_on_list(&req->lentry));
>>> +	WARN_ON(!list_empty(&req->entry));
>>>   	llist_add(&req->lentry, &queue->req_list);
>>=20
>> Are we happy with a WARN here, or should this be handled as an error?
>> The idea of an duplicate R2Ts creating a loop in req_list is
>> frightening.
>>=20
> It is, but wanted to check if others see this as an issue, too.
> We actually should bail out and reset the connection; BUG_ON()
> is pretty harsh, and not really appropriate as this isn't an error
> on our side.

So a malicious or buggy target could trigger WARNs host-side? Did I underst=
and it
correctly?

This doesn't sound ok to me, I think the host should print an error
message and reset the connection.

Maurizio

