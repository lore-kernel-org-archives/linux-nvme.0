Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BFC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 07:38:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEEA61A09
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CEEA61A09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References
	:Message-Id:Date:Subject:Mime-Version:From:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcOZftOIPB4r0uAJLe+Pg56VAFmuAH5o7kKJUEtxQ7w=; b=B97EGvCFoInG9uT1K0xi18k6am
	03ijx1Yxb6ZJ+TFzHicXnu4AjmIS0NSzXM25cN9zwvvdXnd39DubNJljZm0jhZqNPeXc6a63S9DBn
	3GHYnAJD7LMD4CPQI9wkM9xIKOn6LCYySR+eXwGP5j4BGbDFr9CWum1W6brCi3xXrZxdJN/v13nqX
	zXB0nyAZJidSdt1Pkmj5x6PyL7xgPLZiKBU1XVkcU1o0su7QUtqEBocu0dkkUoTzFBOO6ntFd4JKk
	Bp1cdMlzff7kJwm2JkfIJadUDxo04lGOoyHUPHrBK5JJPzZAHRG8N5QIjtnnMZ1/ZnNRZ6S4CABNa
	f89gv5gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnyTW-009cs6-9u; Fri, 19 Nov 2021 07:38:22 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnyTT-009crk-NO
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 07:38:20 +0000
Received: by mail-ed1-x52d.google.com with SMTP id g14so38889816edb.8
 for <linux-nvme@lists.infradead.org>; Thu, 18 Nov 2021 23:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=fcOZftOIPB4r0uAJLe+Pg56VAFmuAH5o7kKJUEtxQ7w=;
 b=JrNP4f4EnHLdrKVwg4tmxvvKYQHOn+W8wogoY+K374sXI2UA0H899+88MFvCem8aJ5
 X3MrqgM+dlqbmvqHyfByhX4BPhJUGbFxxxg7Y91x9i3u2ZV3oLNe86Qa1q4UT5KXfi/3
 By9jJPX1PAfMLLB8OafLnZjRjt16+piRlgH5MW2GlYjZThxLlMs0DSx0yCUbSaCA/7Fr
 srcGbzV9mFszfv2dTzCpcZkj6ZdaFEsY8jI1LEDVOfCHayH0hhz60Af2U0/kTKBR3PFq
 QJzF48P9S+CPgQLheMDNy+jxnzosadzBbkON9Q8J10nQixrb8JFTEDOFUHnsjp8sKwp8
 nMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=fcOZftOIPB4r0uAJLe+Pg56VAFmuAH5o7kKJUEtxQ7w=;
 b=eNYQPB8QOkOrvogn5KpvszapyX48gBfEMQw6zvqTZz8T7Mz52eVn+3crcm6jY5JPoh
 WWUBgtQ6qVc+gd5vR90bBhNdDoy8dyd+D0X4TC8HKOXy6fjpjdR/D/qEzQT7G8/Ik1kN
 7AAFFf8j9o9btmnELZUbmDsMuqKDfY4+XWvI0QdmNBe6RMv24NpExvtE084siypGOEe8
 dJ5WtpnG1ylXmCpKmbM/f4q2fZYiitFXIpAbYcpmCd3dG/Dm67a+JLDAWAZhw7Pqmxt3
 QC7OJCSTtblKmqMenOh8RD4gfQQ6HqIqAjxiv1mSoyOC+V+U0ML6AZE9dqsYJEz1TYZp
 +7bA==
X-Gm-Message-State: AOAM532zAfnaEfMu/6VRy6f9O3CW1Pm4Rdl9c8BObwv+A2qBgvZ2TnML
 pDTkk0P/nTXsQ5cYArVjwHv7rw==
X-Google-Smtp-Source: ABdhPJzl3e3tr3wqllyN2JYawuC7z5WZOElioUzFElEVQo3rNUU9jKhLOL1ITRd1APloUJ9qojdtJA==
X-Received: by 2002:a17:906:fa87:: with SMTP id
 lt7mr5190544ejb.426.1637307497317; 
 Thu, 18 Nov 2021 23:38:17 -0800 (PST)
Received: from smtpclient.apple (5.186.126.13.cgn.fibianet.dk. [5.186.126.13])
 by smtp.gmail.com with ESMTPSA id
 nd36sm823788ejc.17.2021.11.18.23.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Nov 2021 23:38:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Date: Fri, 19 Nov 2021 08:38:16 +0100
Message-Id: <28961370-9842-41B7-8814-DBB20CEEE1E2@javigon.com>
References: <553c2a78-1902-aa10-6cc6-a76cbd14364c@acm.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 lsf-pc@lists.linux-foundation.org, axboe@kernel.dk, msnitzer@redhat.com,
 martin.petersen@oracle.com, roland@purestorage.com, mpatocka@redhat.com,
 hare@suse.de, kbusch@kernel.org, rwheeler@redhat.com, hch@lst.de,
 Frederick.Knight@netapp.com, zach.brown@ni.com, osandov@fb.com,
 Adam Manzanares <a.manzanares@samsung.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>
In-Reply-To: <553c2a78-1902-aa10-6cc6-a76cbd14364c@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Mailer: iPhone Mail (19A404)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_233819_861169_05F35A40 
X-CRM114-Status: UNSURE (   8.39  )
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



> On 17 Nov 2021, at 16.52, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> =EF=BB=BFOn 11/17/21 04:53, Javier Gonz=C3=A1lez wrote:
>> Thanks for sharing this. We will make sure that DM / MD are supported
>> and then we can cover examples. Hopefully, you guys can help with the
>> bits for dm-crypt to make the decision to offload when it make sense.
>=20
> Will ask around to learn who should work on this.

Great. Thanks.=20
>=20
>> I will update the notes to keep them alive. Maybe we can have them open
>> in your github page?
>=20
> Feel free to submit a pull request.

Will do.

Javier=20

