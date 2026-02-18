Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E156E9A047
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4FeULb+Xc3EhbX/0sGSNPb6sVWTLINQREf9xmbBYIw=; b=RmOmfaLyMDkVCXrImUNOvWxqI+
	M3TaxZB7Suoz6g73EFoPqnm9XPYTXz2Le0n8wd0xfavmFPOsv0RlQigZKzEMTz18owIrDx3Tajyek
	2iQqLJadmaSK9GbNu1Yt7WKBDMjIndM03uVNysfOQMWTrT3Ew904/lvllH1BfNWhFtObSboya0x+C
	qpKL767yPLSnv8YV2JNJJtgC4mOBXE2FL90kDIlFVqS4rWwMm5StX+/TVebqTtLFIYxLZxd4iymkI
	iRqTYar4J6rGCIg4pjCEWkEPjSla6lwX8/wJNBRkprYHi5/HNmhyRV2a2BIxD9Iza8TUTfo5xDd1Z
	vrRrjrjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshf1-00000009t0Q-0CMP;
	Wed, 18 Feb 2026 13:32:11 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshey-00000009t03-0iwu
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 13:32:09 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 0e932e85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 14:32:06 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 14:32:06 +0100
Message-Id: <DGI4IURM5EV2.30006D5HWLKUQ@arkamax.eu>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "emilne@redhat.com"
 <emilne@redhat.com>, "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>, "mlombard@bsdbackstore.eu"
 <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 3/5] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Heyne, Maximilian" <mheyne@amazon.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-4-mlombard@redhat.com>
 <20260218-crepe-bambino-1b6d82d0@mheyne-amazon>
In-Reply-To: <20260218-crepe-bambino-1b6d82d0@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_053208_574019_234A2C28 
X-CRM114-Status: GOOD (  12.21  )
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

On Wed Feb 18, 2026 at 2:10 PM CET, Maximilian Heyne wrote:
> On Thu, Feb 12, 2026 at 01:09:49PM +0100, Maurizio Lombardi wrote:
>> From: David Jeffery <djeffery@redhat.com>
>>=20
>> While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
>> timeout target. Instead, use the configured admin queue's timeout value
>> when available to match the device's existing timeout setting.
>>=20
>> Signed-off-by: David Jeffery <djeffery@redhat.com>
>> ---
>>  drivers/nvme/host/pci.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 58f3097888a7..853cd57e4480 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2911,9 +2911,10 @@ static bool __nvme_delete_io_queues(struct nvme_d=
ev *dev, u8 opcode)
>>  {
>>  	int nr_queues =3D dev->online_queues - 1, sent =3D 0;
>>  	unsigned long timeout;
>> +	struct request_queue *q =3D dev->ctrl.admin_q;
>> =20
>>   retry:
>> -	timeout =3D NVME_ADMIN_TIMEOUT;
>> +	timeout =3D q ? q->rq_timeout : NVME_ADMIN_TIMEOUT;
>
> Skimming over the code I think the check is unnecessary since
> ctrl.admin_q is only changed in nvme_alloc_admin_tag_set. Only when this
> succeeds, we'll setup io queues. When they get deleted we will still
> have the ctrl.admin_q being valid.

Yes, afaict you are right and this check is unnecessary, I will remove it.

Maurizio



