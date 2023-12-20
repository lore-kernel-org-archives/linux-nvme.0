Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAFFC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 07:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eJqWdKRl0UBq0Wj+r8chL9QmhrnrulM60eoe1tH98KY=; b=ZRATw9+GxoLKSXIkzw3j6M2Hqj
	A/XZgi/FTTuJA8gQL1zKaEJp65IZBUJTX3A6yyMjwby4naiZfrc7OnToNPyVV2A3YSPjv6gMs5qGW
	ClF9K/p8JcATmOaAl9zcbm7x4qGRo5PjAPmZUulFQAYCFQmTgdIbLbdlzQgd43aIBAC0g7Gjo05V0
	vz1AbCM7gNgLAOQtCUr5nCM1Ssli7ue0CxoQIn3R0f9Hj1MEwEk4bdI9YgYwE98vUt/OTS6djjNAr
	c4OZ/kzMYFyT9d+ziV95TymAXlivdoG2Tn6q1d5RScMEsrNzFFTueWR51YvERrVdrKSE9X/JuLb8a
	7CPLz/sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqui-00GOux-0l;
	Wed, 20 Dec 2023 07:22:44 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqnJ-00GNQr-00;
	Wed, 20 Dec 2023 07:15:06 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d3e2972f65so7024725ad.3;
        Tue, 19 Dec 2023 23:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703056501; x=1703661301; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJqWdKRl0UBq0Wj+r8chL9QmhrnrulM60eoe1tH98KY=;
        b=leyJYD9hw3QbcJE5HdBBxPuArz1mvfLzHHOOyzAyYiKJTPVNfmgeBp7QL2xiGIRGdR
         2D3rmf3bQPSt+eQ6XwcRcMLrCOHr4nn9iuFVuiSG3I8PN5lMispiFakBU+xrB3BMI+wi
         mC4vo6h9nLqVzniYWnKqghSr1lxKRZqbC9hRuemLUlxs7TDC1cBXy6oH7cD9aKoNo+kP
         0bVPGwPeJVjSrQC1Wlo+GblbnFVCNREjcApCg1Sa2E9DXyTro45evynuj10BeAUiKwzh
         jFLwdIha83oxmgJ4ZUZ5EvxqMLL2OpeDXkHLr2hep6SgaYAgFyf+WQJ6lTyYbKEAioGy
         /7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703056501; x=1703661301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJqWdKRl0UBq0Wj+r8chL9QmhrnrulM60eoe1tH98KY=;
        b=nGxekBOB+7K5r5PZ0eJEZ53UbKexSlC8M+9TvBFGg3toLxN5kR9pjdwbrkFfrnbbBM
         3NgUbTA6cdmZeUdXYOyGAsS6W/sCQ7nwp1X8R1K5OoZNfmTzbhISmNXnIEXkiR7ExevX
         0z11SdYa8XIwRueL73vUHC7mM7PMvDsrkiRHcJ3/SU7Ty81FAdHigUk3kaYb21YilE89
         Hl/ksKCitQbcQv+yfaFznu9I89JtGiZq2c1i8gry42ZGARfCA7fVHRFYlq4StKWPByJj
         kTPIk6ArpWq03XPfT1eR3Nun50Yiezv8nP7qrrSyqiPQgPyP4WwJ4X4qB/DG9zC9WRtO
         KHAw==
X-Gm-Message-State: AOJu0YywiLA014opZJNriCDPJDQIbT13zSJvtXRHZ5rdpKouEWWTvjRn
	k+HkY99cYSOLtMX5yU0Yt9hCMKf4b809mw==
X-Google-Smtp-Source: AGHT+IH2/KQGWsEEIk+CfQb//I/X1FN9i9PYn0R8hU2YQDfX0MobECujamcRsnvnV4o1L8WIa9T7SQ==
X-Received: by 2002:a17:903:947:b0:1d3:be34:7862 with SMTP id ma7-20020a170903094700b001d3be347862mr3583611plb.9.1703056501427;
        Tue, 19 Dec 2023 23:15:01 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902bb8200b001cfd2cb1907sm22210314pls.206.2023.12.19.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:15:00 -0800 (PST)
Date: Tue, 19 Dec 2023 21:14:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>,
	"open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>
Subject: Re: Performance drop due to alloc_workqueue() misuse and recent
 change
Message-ID: <ZYKUc7MUGvre2lGQ@slm.duckdns.org>
References: <dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_231505_041260_17AC4566 
X-CRM114-Status: UNSURE (   8.27  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 19 Dec 2023 23:22:43 -0800
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

Hello, again.

On Mon, Dec 04, 2023 at 04:03:47PM +0000, Naohiro Aota wrote:
...
> In summary, we misuse max_active, considering it is a global limit. And,
> the recent commit introduced a huge performance drop in some cases.  We
> need to review alloc_workqueue() usage to check if its max_active setting
> is proper or not.

Can you please test the following branch?

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git unbound-system-wide-max_active

Thanks.

-- 
tejun

