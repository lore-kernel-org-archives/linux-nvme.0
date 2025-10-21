Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE258CCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9JguRQSd4xSpd8WTR1q3NkufPDsiwavfQokKuVuC5oE=; b=TQZVsDRYHyrK10nndyu/KZODmg
	osegpC5kRBTq5m/PpoIs/3OY6PeawQVeXb/Jeo082veEDytLIyOsaiTnXci2qJkAfAVqmdrMULoAk
	tb9Kky6VLMvnYbZGBWb4RP9i+oNQ7Dtn9s9MzBfZFKP8Ure/B9reyjsZIi7QljaOSey5DFvBYG35S
	BAS0nP58lCHCgWRSWa/ZwxFvn94xEm9QI98fIh2MhkyRlxI0eDjWLVyqCSitfSt+g1t4MAbjXMSPm
	hw1BQWuvKdrre9iBxkDTMyjvFyd9FwGoaMiSVlV+RQF1a4tVULMloc8Tz1F5ga2O/7y5uKozxpxyY
	q6mpKl+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB5Ua-0000000FtrN-0oTi;
	Tue, 21 Oct 2025 06:05:08 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB5UW-0000000Ftqe-47Kc
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 06:05:06 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 75c9a110 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Oct 2025 08:05:00 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 08:05:00 +0200
Message-Id: <DDNRV5MAVQCF.2SH49C0P5MKVF@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "sagi"
 <sagi@grimberg.me>, "Maurizio Lombardi" <mlombard@redhat.com>, "kbusch"
 <kbusch@meta.com>
Cc: "hare" <hare@kernel.org>, "linux-nvme" <linux-nvme@lists.infradead.org>,
 "loberman" <loberman@redhat.com>
Subject: =?utf-8?q?Re:_[PATCH_V4_1/2]_nvme-tcp:_Prevent_infinite_loop_if_socket_cl?= =?utf-8?q?oses=0D_during_CONNECTING_state=E3=80=90=E8=AF=B7=E6=B3=A8?= =?utf-8?q?=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6=E7=94=B1sagigrim@gmail.com?= =?utf-8?q?=E4=BB=A3=E5=8F=91=E3=80=91?=
X-Mailer: aerc
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
 <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
 <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
 <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
 <0c60225a-6a48-484e-9526-27e699da4f1a@grimberg.me>
 <DAIV77646KWY.3QL4ZL1IH2630@bsdbackstore.eu>
 <d2ca6b0e-6a76-455d-be90-9e7527e33062@grimberg.me>
 <202510211137214079503@cestc.cn>
In-Reply-To: <202510211137214079503@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_230505_383412_3E7DA5AF 
X-CRM114-Status: GOOD (  13.53  )
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

On Tue Oct 21, 2025 at 5:37 AM CEST, zhang.guanghui@cestc.cn wrote:
> This patch has not been merged yet,
> So far, no other issues were found after merging this patch.

Wait, do not merge it.

nvme_tcp_error_recovery() should only be called when an -ENOPIPE error
is detected. Other errors may be temporary, like -ENOPERM, and we
shouldn't reset the connection in that case.

Merging this patch as-is will make the blktests md/001 fail.

Let me re-post a new version.

Maurizio

> =20
>
> zhang.guanghui@cestc.cn
> =20
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Sagi Grimberg
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A 2025-06-10 22:29
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A Maurizio Lombardi; Maurizio Lombardi=
; kbusch
> =E6=8A=84=E9=80=81=EF=BC=9A hare; linux-nvme; zhang.guanghui; loberman
> =E4=B8=BB=E9=A2=98=EF=BC=9A Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite=
 loop if socket closes during CONNECTING state=E3=80=90=E8=AF=B7=E6=B3=A8=
=E6=84=8F=EF=BC=8C=E9=82=AE=E4=BB=B6=E7=94=B1sagigrim@gmail.com=E4=BB=A3=E5=
=8F=91=E3=80=91
> =20
> =20
> On 10/06/2025 15:50, Maurizio Lombardi wrote:
>> On Fri Apr 18, 2025 at 1:14 PM CEST, Sagi Grimberg wrote:
>>>
>>> On 4/17/25 16:04, Maurizio Lombardi wrote:
>>>> On Mon Apr 14, 2025 at 11:35 PM CEST, Sagi Grimberg wrote:
>>>>> I see the issue, but we need to make sure that if the connection clos=
es
>>>>> before
>>>>> the controller finished establishing, then it cleans up correctly.
>>>>> Because at some
>>>>> point in the past - it wasn't the case. Things have changed in that p=
ath
>>>>> so it might
>>>>> be ok now... Just need to check. I'd trigger the race while the admin
>>>>> queue is establishing, as well
>>>>> as in the middle of the sequence of IO queues are establishing.
>>>> I believe my earlier testing for this patch already covered this scena=
rio,
>>>> but I can rerun the tests to confirm and report back.
>>> So you indeed made sure that the failure starts sporadically in the
>>> controller establishment sequence
>>> and there is no use-after-free issue?
>> Sorry for the long wait; I am now back at it.
>> I repeated the tests using a debug kernel, and nothing has been detected=
.
> =20
> OK, then lets get it merged.
> =20
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> =20
> =20


