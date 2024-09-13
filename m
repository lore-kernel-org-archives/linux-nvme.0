Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B0CFA3746
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tQxfBnnObF3Zdtm8eN3+En1bGTk2XA12yc+yTrm8FU=; b=w66cVrYazYGUsUt8JXAQ6D/gek
	OHSNNUMvh540m7rCzCPrs+ys6ztr4QgYkKxzvqgAwRCtbY/wtbdxHLMZqBBfO6BJCLIxMuc96vafp
	ZjFmL8X0stiB+QGle1pJCF7M37nxLIuFzRn/n1dKsDJ0dPcQ1SpxQSpYVcmvNLEwlPSyshyCWUBqN
	jZ+LQAWzcZ5rj2E56i34aF8QVFr3FQBcF3eciiT1qGX5TgSLtDHmT8b9zKLwGLaXoH6hsk++gSnNx
	dDgJrf7/P+9ftjEAdMT3wN+XfkwA9dxLn9SjyTva831dsJsjBtZprxBBxvUplFI6UvOA/dJ3V7X1W
	6npEmVUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4N8-0000000Fj5R-1uDv;
	Fri, 13 Sep 2024 11:21:54 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4N4-0000000Fj4g-0aPF
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 11:21:52 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5B385C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726226492; bh=7tQxfBnnObF3Zdtm8eN3+En1bGTk2XA12yc+yTrm8FU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=r7IuNEt43FA6r6IcjS/ftkF8YogZJ8dMWX7XTKieqGvI3440bIOfTPl3sbzdmMi6X
	 VSuh3dom1yZetucIQME4vqIVqnQMb/OG1MG6QsqCPJN6Ac0HMyCljWrCAbtWX36RJl
	 L5ml5OtW7dndfdi6P0wcZU9tJrqFC//0gluh+/XeiLWCZXIBXFpwqJUy+lEW5yRf70
	 a1MNQ5t5WCmID8SkhPQnIrlKyDep1OjWVoqy8ioXAzJGjC2gdZnG80nV0V+0/nlGFh
	 DYFVR297Q15lX/+5Fo+xBOZO1i6MAXKhs2TYqAEONqnoP1l1Rb8Ai7K0z4Zs7lpbYh
	 RsIlqwswMU1Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726226492; bh=7tQxfBnnObF3Zdtm8eN3+En1bGTk2XA12yc+yTrm8FU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=RaprHjquLwqxjeY2/1wkcHfp2/5wIhxyAIwa5yj0wxO5kYPvPssfxQ36QnJAhpupa
	 W009Y555ChR0JWWjmTn+pXj/moL/bBWA8/TGj5DUo7T3YE/dQrLPoUwofkkIkdUCBo
	 csL534U/cF8AUXy6ibSQAO5lNlPncOTrZe00TbKf0YsizjVf2NHtjed2Kyfr2s30o9
	 yywbok38TGlOAXVwNEqMUydKZwogHdDlHrb4ctbgZKDgrWsmT2OBeu6dWBvLg4ZryU
	 GhO5X83y2P92JvOQspfhBh2etDRKQif0kwTK/+Y2Q9IhOr13S9cOzF0nLGzB5TMIJh
	 D5Sf++932x1pA==
Date: Fri, 13 Sep 2024 14:20:51 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Caleb Sander <csander@purestorage.com>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>,
	<linux-nvme@lists.infradead.org>, <linux@yadro.com>
Subject: Re: [PATCH 7/7] nvme: allow send fused commands
Message-ID: <20240913112051.GA22571@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
 <20240912064259.5228-8-d.bogdanov@yadro.com>
 <CADUfDZpUJEhowQRis0u==4cKkQPbm7mJJvg6TsaZ-myfFSATJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpUJEhowQRis0u==4cKkQPbm7mJJvg6TsaZ-myfFSATJg@mail.gmail.com>
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_042151_045104_244EB9FC 
X-CRM114-Status: GOOD (  24.96  )
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

Hi,

> There is prior discussion about exactly this change at
> https://github.com/linux-nvme/nvme-cli/issues/318. The concerns raised
> there still appear valid 6 years later. The main issue is that this
> interface requires 2 separate ioctls/io_uring operations to submit a
> Fused Compare and Write. That means the 2 commands could be submitted
> to different I/O queues, which wouldn't work. Not to mention that 2
> threads are required in order to submit the commands concurrently if
> the blocking ioctls are used. Additionally, another application using
> the NVMe controller concurrently could submit a command in between the
> fused commands, which would also break the Fused Compare and Write.

This patch is not for a production usage of Fused commands from the host,
but instead it is just for the purpose to test the target side. Of course,
it has some limitations like working only with one IO queue and one
user, but all of that is under the user's control:

# nvme connect-all -i 1 -t tcp 
# nvme io-passthru --o 0x5 -n 1 -f 0x1 -w --cdw10=0 --cdw12=0x0 -l 4096 -i ./4k0 /dev/nvme0n1 & nvme io-passthru --o 0x1 -n 1 -f 0x2 -w --cdw10=0 --cdw12=0x0 -l 4096 -i ./4k1 /dev/nvme0n1
NVMe command result:00000000
NVMe command result:00000000

And the patch provides enough kernel functionality to test the target side.

> 
> FYI there was a set of patches sent to the mailing list
> https://lore.kernel.org/linux-nvme/20210105224939.1336-1-clay.mayers@kioxia.com/T/#u
> that attempted to implement a new passthru ioctl for submitting fused
> commands. But it adds memory overhead to each NVMe request and there
> are a lot of corner cases to consider around error handling.
> 
> As an implementer of Fused Compare and Write on the target side, I can
> say the concept of "fused commands" is pretty horrible to work with.
> It breaks the model where each NVMe command is an independent
> operation and requires a ton of additional error propagation logic.
> Not to mention that the NSID, SLBA, and NLB parameters are now
> duplicated between the 2 commands... As far as I can tell, the only
> reason to make the operation 2 commands is to allow a separate PRP/SGL
> for each command. I guess this avoids the memcpy that would be
> required if a single concatenated data buffer was used? But at what
> cost???
> 
> On Wed, Sep 11, 2024 at 11:45 PM Dmitry Bogdanov <d.bogdanov@yadro.com> wrote:
> >
> > Allow a user to pass fused flags for the commands.
> >
> > Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

