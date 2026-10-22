Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421E606A324
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FnqFVobp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AS4FBYVv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=; b=FnqFVobppnX8OQdSyq9x/xa4ph
	0GA8ympaWAAW1Q7WjJvkv7m68LFySQTU2h8i1Po3svgQX8byNRwxKeuZqXIXXcxqXfhhizJp1IFqO
	xMVkH8Bsu5d6m8PPqtG38EEt4kPi0l05HSJkwF7zI7W27SGderUgWwPJt3ojGGNNVEIio4zFaQY+5
	N5AL6ZZKwoDTEGyDk/bQWnJllhvYnItp11N1ZcAcooYQjkd//5wZfGExnuJjg3QvBt66rtzd+VYeL
	h7cke+LiWQ4/Zs6giiIy+BsHPW2LXaYJKdLjdsfejknuQxGCwTnjV2Tk1YiqxmDBQRMXvTI1Wj0Bn
	XpVDBztg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJmiI-0000000DWP1-32nM;
	Thu, 22 Oct 2026 06:55:46 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJmiF-0000000DWOW-3QBr
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 06:55:44 +0000
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-4b190cdc9feso1060562b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 23:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792652142; cv=none;
        d=google.com; s=arc-20260327;
        b=HnhemakzL1uD0vMR1hvFF7H7JJWrOQYXxlaHH1KLiwIgwTmTGZRe7p97pKrDs10Knd
         oHayzJTalt/EmrSWSFgoHvRKdeVq8FksUTlu4YAEaHzvItP+/W/HXsdQFeGkW8aELz4Q
         FL94bPEudUGJvXABuaEZXADj+nDwegPM2xwDhgf/Z3dIMTL8UZ15mvjQLjMF2bygqFy6
         t3bu5lDk9ctYowfoua9PsXADcxrGEnuVP531jcQEb6do92SblgM9BzsTVOivPSgwcZ58
         cFmaiwZLDpj/3Ty3z+eRfs1/vdeYoskRK6MZAgOBLjO2NMPe+vFc6WWVMYQWKYa8KIIi
         gzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
        fh=PxzbUx9ZgAwMqdf4pFk2ezHbodfpb1sOgf0Df+yU3f0=;
        b=jsN5W2evW/fNOfpFG56f0T/33AG/+GyT9jotrc4o/PGhd3WOTQk9XGvJIV4BNAO1BF
         Vo85S5NYMtArWXEMR8TMJuezmA9dbVMH3iLfUV8RlejHDPeGMckM47lLyJzqDG2ppeGX
         zfT7oMa8oEQZIm33/MKnXpWaCoMTZOqP3Lt1UR59FZRyTxk3VlwuDPiHHN/n5XYHJLUt
         zm7B9bVoTzn6wkT3Z+t8ln2h6YP8g9p0Z+xQ3j7vhM9rrKqXCOdmuNPk1xVNdq4TfLY1
         e1NM61lQ5Qfn4hbEiHEwUzBOzl+dEvv6H3F/3FTkJsw9jKWfqJ7EL+3P514PfrfrMiZv
         8VNA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652142; x=1793256942; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
        b=AS4FBYVv8+pzpsdqZupIH7EOGD7W3p7bk7o5vcT/y+4el7/pmDHSZ9bD2r1MtPXOFU
         PO3T/z91GQOAb/oq5TWtXjWRugRyD9JEgo2Qv0Ldn/vUJ5DgEWc5JX4HqPRZKbetGRLl
         XphtQLZ3hRfoBS+XYVRk3SNmfs7HzpzXYfvDh1qGriVzfftWON1+RAIBKIfn7XX8ez1g
         dMMqdsjUGzjg3U8rR3Vrz44sLhyISBXWArUzSQDw20p/M6HG4PTjjnz3t9PT7WQ5vdoE
         nfg6/RsMZ2llo4lz35IiSYgJmYUg6Qsm8h4g/3uIsvMI3yRfstB9VkHoNY2GPKtdPStj
         mYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652142; x=1793256942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+qOAfSouOX0t5YZwWU2eSWaqspMZR2wrvfeU+oUpg14=;
        b=2Q64N60QBlxaZ9+0p09/1QTIPEEYUhirgZZRuXI5eY3EDjwpau4qaVkcDnbdy3RJut
         RIZCJD3tL5l8NOBBdVmZef6wBQi4x1XQKSGsZ1bfeKnknibQVnFDLFklUlYaAW6T7Tgf
         KTTI/A1DqVGQkfaFce4ElyK/OcI2vWmOp2p696iZtnYB++pknY1f9/i5RDj66mrArYgP
         XSYMCEQnFcp9Gq+vM6tGwaK8rwBRdI0+b/6nWk8ijmhYbLvZmGdjnwxfXdyHgHpFWKnr
         uZKb0MXwxuG9F0ca1+RidAgnAwLiJ+Zlu3D9mWlk6xoggSd3UkXGzgV7/ykLyenRFL11
         xt5A==
X-Forwarded-Encrypted: i=1; AKwUvBz0eQRtsEXhwI3Zb0udDyrNM8mxeNrGSWy7ZHkzwWXQQQej2iZFhK3QipnIeMi7ffmJdxYgpGg0oNb7@lists.infradead.org
X-Gm-Message-State: AFq9FYIul5rj/XoGV0v0Qy/dfVxZmjQc6B9knSfU1j4QMo+UHu/kkNHI
	hkhuaFcoU0AMV7PZD3vVRirlZeHQa2D3TCa6715yvSAZx2koyVFCaXvoUZuxrrutleMrEYwVdCC
	MxGThWDnjJRw6m08fKLi4QelcX3w4jJo=
X-Gm-Gg: AYBFou0tmFiMboX5mfMBfA5vgMr9fja2gKU0FLoDE4gMG5shojC4RR3eNkJJ8+LwtM+
	5nEEBUQy4Z9u5jWN6chyIL9nKLvHjcDP3Qts4cWm+lRHn4csrxBFN2cIm4yKhMNA3fkiDqZ2Ogg
	F72RoA6pjRXDzjE0wos6N9RzVTm41vdRO//Sz8/i5n94aOwyN4F5l1NGvWPvfPtSwoxFcARTpwc
	oicTLyFAh8fLt8mDlePZxKDLtT3d3cM6x77pbnrefxcYIq8zq5eCI/AIpIsT5N572CMGY+QSuZy
	KHD0yOtkkqmeDK8Yfh8MLv7a1sUayrfwyPyY+RLCh037AX1C4WfFKUpS2UD6/qg982olA2W4NAb
	BVdml/IJcXZp6QevFgdjpIPw0jTSc6M35yMKslBOU2TnBrYFIb9cJCfHhHH2f1xwkWd9kZkrkHo
	AVUZ1Mk3wASdrPWg==
X-Received: by 2002:a05:6808:d4c:b0:4f5:e13:95e2 with SMTP id
 5614622812f47-5534f511f07mr3092508b6e.9.1792652142362; Wed, 21 Oct 2026
 23:55:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002152821.410591-1-yupeng0921@gmail.com> <CAG3TDc1Ydhjx1GD7-ZCqmzYbZv5+DM0O7wPnzKLWJ1ycK9C2sQ@mail.gmail.com>
 <66f87058e7e811af340d920e654117eb@kernel.org>
In-Reply-To: <66f87058e7e811af340d920e654117eb@kernel.org>
From: peng yu <yupeng0921@gmail.com>
Date: Wed, 21 Oct 2026 23:55:30 -0700
X-Gm-Features: AclHuK8Sypv-7xRYs_lPJ7h3Nm6lMdPqTsjMnjk1hM_VRIlE-PXSuRDM8lifbow
Message-ID: <CAG3TDc1BgQNuCD75NTCcpmP_d4aLummSP6AN6JuxoAgeEBfmFw@mail.gmail.com>
Subject: Re: [PATCH v8] nvmet: add cgroup_id to charge namespace I/O to a cgroup
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_235543_858798_8ECC4E73 
X-CRM114-Status: GOOD (  17.13  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 2:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Peng.
>
> On Tue, Oct 20, 2026 at 06:01:12PM -0700, peng yu wrote:
> > Hi Tejun, does this patch look good from the cgroup perspective?
>
> From the cgroup core side, this looks okay to me. However, the current
> implementation will block the shared submitter when throttled, and it
> would probably need more work to behave well.

Currently the io.max won't block the shared submitters but io.cost and
io.latency will. If a nvmet subsystem has two namespaces, one namespace is
blocked by the io.cost or io.latency, the IOs of another namesapce will be
blocked too. I plan to create a v9 patch, if a namespace has a cgroup, it
will submit the IOs via the nvmet_wq, then this namespaces won't impact eac=
h
other. If it is not the correct way, please let me know.


> Thanks.
>
> --
> tejun

