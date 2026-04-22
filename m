Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28060FA1FFE
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 21:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:
	Date:In-Reply-To:From:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cgpza/ygVqVA9S3quWs8Q35TCmfB+GLC9CQWXkpoesk=; b=gfGawp2nsIgDfEF7nRJ/1qPnCP
	gBAnt2ODarxmiBG8xc4RhzpOkkiz8sr/Azo1Lj3jVmaugIKPbMD7rJ1svBBfJs/UdpKgqc/t0o4E5
	4Hn+DDCnwno7Z2Vn8ydyXKbulMcRY4OUw5qQWxsmBqFwibyjkfQCL+nT2xk5//lzLLSfKRLhv0vTd
	SG3xpnhLNO2P1hLfrmax+c6mcSbiuY6Mv0l6nz8RIrzh7lTFK1DRPkCF73v2Vvj+JYVPEj7ary3G1
	DQNUyT3bjb8T76hTOJhWmlcbH0TWmEEifE4pklcIw16GSXRhBlvLrCGFVoBQaUI2UVXLAGhop5Ahj
	q/aVFVaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFf7k-0000000Alb2-0etL;
	Wed, 22 Apr 2026 21:28:44 +0000
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFf7e-0000000Alae-1ARF
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 21:28:39 +0000
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776893313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cgpza/ygVqVA9S3quWs8Q35TCmfB+GLC9CQWXkpoesk=;
	b=daA1nv4EjYnSQLIE7dEMjIdoIMZC+orNAQvKRf1ByycCi4bPaBGaW2hGTdZwDfyOdXa2qb
	0glFoOF2Dq6n0hpicGLRRDEUCYyZl+PTLFy5IJHVTiLMpzuAZq8Q2iKR/VLZKTaJzprZpO
	1cwVSZV6Ayy/jV1maIfiGf0YJyB+YWs=
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
Date: Wed, 22 Apr 2026 14:28:17 -0700
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Message-Id: <32CD853E-921D-4EEA-B1D0-4E4A7537861A@linux.dev>
References: <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_142838_523530_B5B4D2DF 
X-CRM114-Status: GOOD (  10.12  )
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

I suggest LSFMMBPFLLM :)

> On Apr 22, 2026, at 1:30=E2=80=AFPM, Bart Van Assche <bvanassche@acm.org> w=
rote:
>=20
> =EF=BB=BFOn 1/10/26 5:24 AM, Christian Brauner wrote:
>> The annual Linux Storage, Filesystem, Memory Management, and BPF
>> (LSF/MM/BPF) Summit for 2026 will be held May 4=E2=80=936, 2026 in Zagreb=
,
>> Croatia.
>> LSF/MM/BPF is an invitation-only technical workshop to map out
>> improvements to the Linux storage, filesystem, BPF, and memory
>> management subsystems that will make their way into the mainline
>> kernel within the coming years.
>> LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
>> subsystem-specific tracks, cross-track discussions, as well as BoF and
>> hacking sessions. Please check out:
>>           https://events.linuxfoundation.org/lsfmmbpf/
>> for further details on the venue and hotels.
>=20
> Thank you Christian for being one of the organizers of the
> LSF/MM/BPF summit. Will a schedule be made available before the summit
> starts? A link to the 2024 schedule is available at
> https://lore.kernel.org/all/20240510212132.83346-1-sj@kernel.org/.
>=20
> Thanks,
>=20
> Bart.
>=20
>=20

