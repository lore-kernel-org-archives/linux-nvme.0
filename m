Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05920C5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=; b=BRg2mQoBE3sHJPDX3iWQoZ/a55
	GCcEg5xVDGx0lMaqas+0swiejmkfx9jkgZapRn0yh2eMKYvjD8E6PvBYnyoc/lkgpgvZ+Olevy83Z
	SMgDtV2rYR6tNcTwny+CCjbJSWappI1G435aj8I9fhXQP0gDwdsqPGE4r1p7dvhiMuqpggzO0cZyB
	PDMiNmND20JQ7rPrOegzOhZOkjjxQbAiec+mBLLWGasCrPSS0fpS31SfDAuDEYVdjl4bQ/yDlWSAR
	dDHie6uxj7T6jsn7Y3DmU+Au90IwwcTtAzjfc9owv9M0+D25s6/1tzbDh8wWmok7Y4mScAO7YU7ma
	FjRvqxCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYEx-000000019jG-30XN;
	Thu, 13 Aug 2026 16:25:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYEn-000000019hf-3AvI
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 16:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786638300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=;
	b=PW4cE+Hsvl1XQ6sUouW3PFnx0N2x28IaFAtz8b1ITwSqGJ8rW8XJh3xkSmHJNKaq98iH4w
	t4Q3SDyy5tlabLDTUi9Uc6Dze9TNbcCv1uJNwq/+DisVfFqO7HbMvhXJaFF3sZdlFEOw5Q
	i6U5+X3AVI/HnvLKOvQMbONm3Td6eEw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-g9y-vTG9OH2yijjv6yMSLw-1; Thu, 13 Aug 2026 12:24:58 -0400
X-MC-Unique: g9y-vTG9OH2yijjv6yMSLw-1
X-Mimecast-MFC-AGG-ID: g9y-vTG9OH2yijjv6yMSLw_1786638297
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495529a93f9so856435e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2026 09:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786638297; x=1787243097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xDjRetmtu85IwRz4yKH8gCl8QTGFcjeWkycVMxdyxng=;
        b=UdJ/EfwNnDKrAEwJFaYu8lBngWyfYHi/fLeL0aBkC0BZv3yKEBFnOZtWRJal5OSh/F
         ix1TMUIqqxJh6a0zrU5fdJAoNGeJmx1VWdxT1m7Zk3K6kh9B1H+HjfxChnbQpAiCJxFt
         3OJyZobdXXGmz6ZinMK/RtlQP0NB8pBHinOkA4QPqP+l0G/IAiZmqE73ZXEELWGXLgzK
         joDD+Teeb89TgcmHMcn37ZZt+wk0MVkPdOIGiAu80h7tEtosICaAUw0mqejdmBPzjnyN
         NexokK8WwXnxdNCqqe+oPXjhatVGIGrBdsB7ssFLk7aZdC0hj6zxltHXtWhgVd2e23mD
         XUcw==
X-Forwarded-Encrypted: i=1; AHgh+RrwzKhB9R1A5DFDOo3tzssSBQDC9160EHOJBXciw3cc0wt94p64xJLs+2NZ28w6ZZhtf85viLMmte8o@lists.infradead.org
X-Gm-Message-State: AOJu0Ywuy7r8DF0SCiFk04V/HadRU+jHDckCWwGcA/9njpcGdLLAsZR5
	r/ObnqYtCOeJJ1y5o6czoW9RBpsFUctbKLo7cWfwFjV0GXdYsLot3wz04E17H00IT7ogYOnNNcy
	0SOAUY4XzuDVutpMlv4RekaCH4/hvP1h8XP6vBc2Fd8VXqW4fooQINj7sAtNgZlBJH9W7iRpqX2
	8pS58gdH1i3MbZ8Tjd8SRiqGJ4NvzIOt5Bbl5UXNvsTxk=
X-Gm-Gg: AR+sD10csNN4/7LIWO3ct4BttXq3jLfC/X8qPQsPXz8h3aaewhcHwdhL9P4kq8bD2Ny
	JOmglNadbQz52mYFAQHSVDcflIsKcYExQOldjlP+vnps6C7Oynak6CR0tBz9ExS9DA/88QiCkNA
	wxL7Hb5ALDt81uutbIHRZI5AlipPIsRk5L9Tv69pBbIZQs8DBozCBM+PpF94Qa1lwenvgjPFwm+
	QA2r3WJsyWbTlehZA==
X-Received: by 2002:a05:600c:4692:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-499821c5a55mr85647645e9.3.1786638296955;
        Thu, 13 Aug 2026 09:24:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4692:b0:499:781e:25fc with SMTP id
 5b1f17b1804b1-499821c5a55mr85646715e9.3.1786638296566; Thu, 13 Aug 2026
 09:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260812181300.3712426-1-jtaubepe@redhat.com> <CO6PR18MB450084465A542D9DF1E46C51AFDB2@CO6PR18MB4500.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB450084465A542D9DF1E46C51AFDB2@CO6PR18MB4500.namprd18.prod.outlook.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Thu, 13 Aug 2026 12:24:45 -0400
X-Gm-Features: AUfX_mxnzn0QQGs-cPHrzMNrM17HgyUB_gFx1iWfyyxeIkP3fWyqO39kLk3cHho
Message-ID: <CADRr4bceLLuu4KRf7X+P6aNyBtK+TGrBDKd4T5Uuw5DaM-9gXg@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 00/13] nvme-fc: FPIN link integrity handling
To: Nilesh Javali <njavali@marvell.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"GR-QLogic-Storage-Upstream@marvell.com" <GR-QLogic-Storage-Upstream@marvell.com>, Hannes Reinecke <hare@suse.de>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, John Meneghini <jmeneghi@redhat.com>, 
	Bryan Gurney <bgurney@redhat.com>, Chris Leech <cleech@redhat.com>, 
	"Ewan D . Milne" <emilne@redhat.com>, 
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rwfy6S8K9oVpbPaQl6fR0WMoS6Wnrx6ETaWHEwRMPfM_1786638297
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_092502_308559_9EFB5283 
X-CRM114-Status: GOOD (  37.98  )
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

On Thu, Aug 13, 2026 at 12:54=E2=80=AFAM Nilesh Javali <njavali@marvell.com=
> wrote:
>
>
> From: Jesse Taube <jtaubepe@redhat.com>
> Sent: Wednesday, August 12, 2026 11:43 PM
> To: linux-scsi@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.o=
rg>; Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@kernel.dk>; Christo=
ph Hellwig <hch@lst.de>; Sagi Grimberg <sagi@grimberg.me>; Justin Tee <just=
in.tee@broadcom.com>; Naresh Gottumukkala <nareshgottumukkala83@gmail.com>;=
 Paul Ely <paul.ely@broadcom.com>; Chaitanya Kulkarni <kch@nvidia.com>; Jam=
es E.J. Bottomley <James.Bottomley@HansenPartnership.com>; Martin K. Peters=
en <martin.petersen@oracle.com>; Nilesh Javali <njavali@marvell.com>; GR-QL=
ogic-Storage-Upstream@marvell.com; Hannes Reinecke <hare@suse.de>; Jesse Ta=
ube <jtaubepe@redhat.com>; Gustavo A. R. Silva <gustavoars@kernel.org>; Joh=
n Meneghini <jmeneghi@redhat.com>; Bryan Gurney <bgurney@redhat.com>; Chris=
 Leech <cleech@redhat.com>; Ewan D . Milne <emilne@redhat.com>; shinichiro.=
kawasaki@wdc.com; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; =
linux-nvme@lists.infradead.org; linux-block@vger.kernel.org
> Subject: [EXTERNAL] [PATCH 00/13] nvme-fc: FPIN link integrity handling
>
> FPIN LI (link integrity) messages are received when the attached fabric d=
etects hardware errors. In response to these messages I/O should be directe=
d away from the affected ports, and only used as a last resort. This patch =
adds a new controller
> ZjQcmQRYFpfptBannerStart
> Prioritize security for external emails:
> Confirm sender and content safety before clicking links or opening attach=
ments
>   https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!te3Z1f8UYnTa1E=
-duf06bvZlnS-1FrR2Jkcx8WQcjCWqN2c_NKqyKXnJoJcD4hWMKkUnua_-glfm3m67hWRah9Kf0=
UTKp-APm3w$  =E2=80=8C
>
>
> ZjQcmQRYFpfptBannerEnd
> FPIN LI (link integrity) messages are received when the attached fabric
> detects hardware errors. In response to these messages I/O should be
> directed away from the affected ports, and only used as a last resort.
> This patch adds a new controller flag 'NVME_CTRL_MARGINAL' which will be
> checked during multipath path selection, causing the path to be skipped
> when checking for paths. If no other paths are available the 'marginal'
> paths are considered for path selection.
>
> The testing for this patch set was performed by Bryan Gurney, using the
> process outlined by John Meneghini's presentation at LSFMM 2024, where
> the fibre channel switch sends an FPIN notification on a specific switch
> port, and the following is checked on the initiator:
>
> 1. The controllers corresponding to the paths on the port that has
> received the notification are showing a set NVME_CTRL_MARGINAL flag.
>
>    \
>     +- nvme4 fc traddr=3Dc,host_traddr=3De live optimized
>     +- nvme5 fc traddr=3D8,host_traddr=3De live non-optimized
>     +- nvme8 fc traddr=3De,host_traddr=3Df marginal optimized
>     +- nvme9 fc traddr=3Da,host_traddr=3Df marginal non-optimized
>
> 2. The I/O statistics of the test namespace show no I/O activity on the
> controllers with NVME_CTRL_MARGINAL set.
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     25001.00         0.00        97.66         0.00
>    nvme4c9n1     25000.00         0.00        97.66         0.00
>    nvme4n1       50011.00         0.00       195.36         0.00
>
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     48360.00         0.00       188.91         0.00
>    nvme4c9n1      1642.00         0.00         6.41         0.00
>    nvme4n1       49981.00         0.00       195.24         0.00
>
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     50001.00         0.00       195.32         0.00
>    nvme4c9n1         0.00         0.00         0.00         0.00
>    nvme4n1       50016.00         0.00       195.38         0.00
>
> Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__people.redha=
t.com_jmeneghi_LSFMM-5F2024_LSFMM-5F2024-5FNVMe-5FCancel-5Fand-5FFPIN.pdf&d=
=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57sfPbDDcMFJyBD6G2keJbhsQZV7WIf=
8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTGHA24wKzPP99uuwXoNoSYqcE55NQRq=
t6_&s=3D0jhQeJW2swbeXGSnNtXSHqXkNX1eVjXmU7QSm6m2IpU&e=3D
>
> Testing has been performed by sending all FPIN LI ELS messages from the
> switch to the Host and verifying the proper nvme multi-pathing behavior
> is effected with each of the eight different FPIN link integrity events.
> Results were verified with iostat and with the nvme list-subsys command.
>
> These tests were run with all scenarios including where there were only
> non-optimized paths available, and where all paths were
> marginal/degraded. All multi-path io-policies were tested including:
> numa, round-robin and queue-depth. When all paths on the host are
> marginal/degraded, I/O continues on the optimized path that was most
> recently non-marginal.  If both of the optimized paths are down, I/O
> properly continues on one of the marginal/degraded non-optimized paths.
>
> Testing has been complete with both Broadcom (lpfc) and Marvell (qla2xx)
> 32GB HBAs.  Both HBAs successfully complete all tests.
>
> For a complete description of the tests that were run, please see
> bugzilla 220329.
>
> To test the path handeling use:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_linux-2=
Dblktests_blktests_pull_264&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57=
sfPbDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTG=
HA24wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DXKJyyaOO9_UGG6uH5fv88U7bAke7X9H5Xz0qa3=
9qubs&e=3D
> or
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_li=
nux-2Dnvme_20260812174503.3705830-2D1-2Djtaubepe-40redhat.com_&d=3DDwIDAg&c=
=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57sfPbDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=
=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTGHA24wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DqPf=
emamvpsdH9yAG-9CRAILRyvMrzEaa_xjIaJTo1Ds&e=3D
>
> To test the full set including FPIN decoding use:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_johnmen=
eghini_fpin-5Fli-5Ftests&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D7My57sfP=
bDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaKWe2JBe94gTGHA2=
4wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DSzJUICtyPkmr7xYyCu6_gZb5itPn8MZRQm4z0Zoew=
ak&e=3D
>
> Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.k=
ernel.org_show-5Fbug.cgi-3Fid-3D220329&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3D7My57sfPbDDcMFJyBD6G2keJbhsQZV7WIf8SjB-450c&m=3DViZhyiiF6nkaVXOE1PpaK=
We2JBe94gTGHA24wKzPP99uuwXoNoSYqcE55NQRqt6_&s=3DYbu1spaO4qBWAVWu7hq8KHIP73x=
HRmGPfJCrZVoqacY&e=3D
>
> New refactored implementation enables administrators to manually control
> port marginal states via sysfs. For example:
>
> # Set remote port to marginal state
> echo "Marginal" > /sys/class/fc_remote_ports/rport-4:0-1/port_state
>
> # Clear marginal state (set to online)
> echo "Online" > /sys/class/fc_remote_ports/rport-4:0-1/port_state
>
> Changes to the original submission:
> - Changed flag name to 'marginal'
> - Do not block marginal path; influence path selection instead
>   to de-prioritize marginal paths
>
> Changes to v2:
> - Split off driver-specific modifications
> - Introduce 'union fc_tlv_desc' to avoid casts
>
> Changes to v3:
> - Include reviews from Justin Tee
> - Split marginal path handling patch
>
> Changes to v4:
> - Change 'u8' to '__u8' on fc_tlv_desc to fix a failure to build
> - Print 'marginal' instead of 'live' in the state of controllers
>   when they are marginal
>
> Changes to v5:
> - Minor spelling corrections to patch descriptions
>
> Changes to v6:
> - No code changes; added note about additional testing
>
> Changes to v7:
> - Split nvme core marginal flag addition into its own patch
> - Add patch for queue_depth marginal path support
>
> Changes to v8:
> - Rebased patch series to nvme-6.17.
> - Added patch from Gustavo Silva, "scsi: qla2xxx: Fix memcpy field-spanni=
ng
>   write issue", which resolves the field-spanning write issue
> - We decided to leave the "marginal" state as is, because the transport
>   driver uses the term "marginal".
>
> Changes to v9:
> - Rebased patch series to nvme-6.18.
> - Refactor and fix a patch from Gustavo Silva, "scsi: qla2xxx: Fix 2 memc=
py
>   field-spanning write issue", which resolves the field-spanning write
>   issue.
>   This new version of Gustavo's patch fixes a bug found in testing.
>
> [NJ:] I could not find this qla2xxx fix in this series. Am I missing some=
thing.
> This fix is certainly required to avoid few call traces reported, as disc=
ussed here,
> https://lore.kernel.org/linux-nvme/97526d45-ec7d-48a0-bdc6-659f75839f53@e=
mbeddedor.com/#t

You fix:
Commit 7db93e3c580d ("scsi: qla2xxx: Enhance purex_entry handling for
29xx series")
fixes the issue.

I forgot to mention it in the change log for V11. i will include it in
the change log for V12.

Thanks,
Jesse Taube

>
> Thanks,
> Nilesh
>


