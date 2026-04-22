Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3553FA1FF0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZQPUhx+rXb0qQBkKzoRsQxVCKYwUq/JfEdgKMzTeTk=; b=wBZiV3eAHjaCPK2TwKYoANQC0C
	xD2H45n+GqOZCJHV9/2rsynzCFP49tzRKW9YDRwnqgmYYHLLnOcuZwwq5bRFAovF6uG7JMI2EbKaC
	YgShxRo4BRMNWMSc2ZmCea2WAWv9mk+T8Z4V4HHu6JSua+eB5wE2gpXvLkpbL6l9HG/s6j7KFgF1j
	aUPaAiov2L9WfZO5WsKfQPtTQUEhg6ES6DCjZBnGbUZJ/5nSujb22fU6UZZ5T6xNivkdMPxFUgIgn
	ouY2KjEV2IXO8JaBO0kIfhjuOAss4bnxQkbyFOxLbBKWVdXHgM3/lXC14YHPTeBsxOH+XH1uud+R/
	AV12R+dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFeD4-0000000Aj3F-163t;
	Wed, 22 Apr 2026 20:30:10 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFeD1-0000000Aj2T-0BhK
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 20:30:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g19nn1cZKzlffvg;
	Wed, 22 Apr 2026 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776889799; x=1779481800; bh=VZQPUhx+rXb0qQBkKzoRsQxV
	CKYwUq/JfEdgKMzTeTk=; b=HNCt/eZM92V4a8DUsj//sCu4BVDsEhMIQqH9AWxf
	A9dFwDjzecKhicDRODlprsewUD3xYpBqLhcykXGooDqbWvZW4KTXDDe6d2Drbez8
	9WpsCKdl+/Jj/eRaV13QthXvPnPzFNVZ2JGwraMMHd8tcYhNSl4c1Gc1yXXMifES
	db6PEK5zxfKV6Ytkf4zqDR3JStar0DXdOK7AxfSh1KyFJMd7qWlrMNNFcc8Lk4jh
	ghEEAEt848HZX4nw3Xh1n90K1T50fdoL1yslUTj9b8KYdLxp5pb7rN0DOZxKTSDc
	ImqYZpEoFytrKLhitP4ypYnIrE0Mvoll0LN+QsYfeJ5yRQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MpgyuWK0q_50; Wed, 22 Apr 2026 20:29:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g19nd4DxMzlfl5n;
	Wed, 22 Apr 2026 20:29:56 +0000 (UTC)
Message-ID: <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
Date: Wed, 22 Apr 2026 13:29:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_133007_128526_DD2101D4 
X-CRM114-Status: GOOD (  10.37  )
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

On 1/10/26 5:24 AM, Christian Brauner wrote:
> The annual Linux Storage, Filesystem, Memory Management, and BPF
> (LSF/MM/BPF) Summit for 2026 will be held May 4=E2=80=936, 2026 in Zagr=
eb,
> Croatia.
>=20
> LSF/MM/BPF is an invitation-only technical workshop to map out
> improvements to the Linux storage, filesystem, BPF, and memory
> management subsystems that will make their way into the mainline
> kernel within the coming years.
>=20
> LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
> subsystem-specific tracks, cross-track discussions, as well as BoF and
> hacking sessions. Please check out:
>=20
>            https://events.linuxfoundation.org/lsfmmbpf/
>=20
> for further details on the venue and hotels.

Thank you Christian for being one of the organizers of the
LSF/MM/BPF summit. Will a schedule be made available before the summit
starts? A link to the 2024 schedule is available at
https://lore.kernel.org/all/20240510212132.83346-1-sj@kernel.org/.

Thanks,

Bart.


