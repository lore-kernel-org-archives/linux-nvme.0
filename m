Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87BBFCD0C3
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Of/9XPjU5767m0fIs3RagkayKDqTCmMoqNRmutg7NO8=; b=Z8ZTkFw1MUh3oXC+7iGCsI5pZr
	zUSSOBTLdiUljwAThNUfskzxAUmupC+yEtKgSsCoOn37DV/z7PFmb8DoZ2MtM/EcX1pQIvFhi7x+K
	6UcvZNdyRbB8wwpwcfJ9pyLHjjXkMRHm9SzqHeXbmdkYtrQyGAmJR6McfvieiPi/3K6TaxNUv3npv
	U/OE8xYH2JJ4gnZmgOIh2HrhXNExrf5Yl9zSljmzwx+R8LAJpdt33Wus7jAn0dMDkGMif9IO1KI3B
	upmNU7Vu/5SrR/6qPYoFp6jlhHlytMTbNDkSuD3NUAMmJwDXws+90QgMAaaTMAD0mTwUpg24OPIQT
	HIG1TFsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2lCr-00000007v37-48Os;
	Wed, 18 Mar 2026 07:20:41 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2lCo-00000007v2f-208Q
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 07:20:40 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9878ebe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Mar 2026 08:20:35 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 08:20:35 +0100
Message-Id: <DH5Q5NRU3T5F.353ZBVB5KVQUN@arkamax.eu>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>, "yjshin0438@gmail.com"
 <yjshin0438@gmail.com>, "hare@suse.de" <hare@suse.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "mlombard@arkamax.eu" <mlombard@arkamax.eu>
Subject: Re: [PATCH V3 0/2] nvmet-tcp: fix receive path error handling and
 state machine
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Chaitanya Kulkarni" <chaitanyak@nvidia.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260316143936.120999-1-mlombard@redhat.com>
 <3a4e57c8-13ba-41b2-90d4-4b0d4a22cab0@nvidia.com>
In-Reply-To: <3a4e57c8-13ba-41b2-90d4-4b0d4a22cab0@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_002038_856709_87F5A397 
X-CRM114-Status: GOOD (  11.86  )
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

On Wed Mar 18, 2026 at 1:24 AM CET, Chaitanya Kulkarni wrote:
> On 3/16/26 07:39, Maurizio Lombardi wrote:
>> Patch 1 fixes a potential issue where network data could be read into an
>> uninitialized iterator. Currently, nvmet_tcp_build_pdu_iovec() returns v=
oid,
>> meaning callers are unaware if an out-of-bounds PDU length or offset tri=
ggers
>> an early return. Consequently, callers blindly overwrite the queue state=
 to
>> NVMET_TCP_RECV_DATA. This patch modifies the function to return an error=
 code,
>> shifting the handling responsibility to the callers to ensure proper soc=
ket
>> teardown.
>>
>> Patch 2 cleans up redundant, localized calls to nvmet_tcp_fatal_error() =
scattered
>> across the receive path. It delegates the responsibility of executing th=
e fatal
>> error function to the top-level caller by bubbling up the error codes.
>>
>> V3: remove nvmet_tcp_fatal_error(), fold it into nvmet_tcp_socket_error(=
)
>>
>> V2: some cosmetic changes to Patch 1, no functional changes.
>>
>> Maurizio Lombardi (2):
>>    nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its caller=
s
>>    nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()
>>
>>   drivers/nvme/target/tcp.c | 88 ++++++++++++++++-----------------------
>>   1 file changed, 36 insertions(+), 52 deletions(-)
>>
> Assuming that you have ran block test on this series with nvme_trtype=3Dt=
cp
> and this series is passing without any problem.

Yes, Yi Zhang did run the blktests against this patchset

The only problem he reported is a circular locking
warning in the host driver that I think is due to the bug here:

https://lore.kernel.org/linux-nvme/f5065c2c-e30d-418d-8c7a-723e958b54c1@nvi=
dia.com/T/#mb3a8789682514d5f63b711703d32fd6bd197bcec

No other issues were detected.

Thanks,
Maurizio



