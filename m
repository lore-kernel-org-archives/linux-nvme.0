Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC13D3515F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2G8HQZdo/hL42mv2+fbZLC0xjtjjfLEKcvrD6H7H/Zs=; b=ofYbDNizknguBzI9aKJah8U48N
	fWNgDszaGWVdpIR2XVnv7FBb4nv2+Jov+OR8KlUQ33by04tJ7+PunNj/t5MHLYc1O90dpkKvDGOXi
	Rv4lCwG5I0HTFhoL9tEuFD3yp9Vmk9zL8gOgFmdbJ3qntwmtVkhx7RoUFz+MG8xUmZP7V2G7RMe2z
	AEfgSDH9GpvOA8EScq6iM7s/mdZbTnCI6ujkv3u34XJgzrGuXC3CHg1c2HzcF0xUQLLaxiiAGKfub
	bdOdlJPcQuvuXHpH/+WUmpM0Tl5q91ki2aJNp1ii4HAgeIlYHPfERO1nfZ4vGx/QgZoVzMWjX4WcK
	1kCni0IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7rVh-0000000EMRw-3s0v;
	Wed, 01 Apr 2026 09:05:13 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7rVf-0000000EMRV-0Tgj
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 09:05:12 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72FCAE3A78;
	Wed,  1 Apr 2026 11:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1775034301; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2G8HQZdo/hL42mv2+fbZLC0xjtjjfLEKcvrD6H7H/Zs=;
	b=DCsEYDpYckVeq1CpePyDuVB7i43qI2xvSMqp9G6Zcyt0WfLxDtrYa7yjdes1yF9e8qJIQn
	2DqLh4G7pZ/vV2mupTeNWDpvG4BmOmOv6gYB36oTpIbPIIvYvPf9D3ci/uBT7Mvgoi3Fzz
	mDxTMe6sHlbnHMWNXVg0Bm5GLtmwqv/Kd4jDhRN3ZIZX7F/4xt2iRpxDtm5+T0O9Xy+Buu
	tdCrY4ySs3P2pPJ2nzadsYnOq787Tbxu7L2FWISCB6+9nfLzaoC3Xas8lXo16/jCubFSBW
	CKrNTKmGJ/+BTDw+8nGrl00baEMiYSHYZvT0n7UZCAVCbihIcqhO24WMnr+bOA==
Date: Wed, 1 Apr 2026 11:04:56 +0200
From: Daniel Wagner <wagi@monom.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: expose TLS mode
Message-ID: <c12c0c26-4f02-4e5e-9f84-fa7fed21419d@nitrogen.local>
References: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_020511_435727_16232168 
X-CRM114-Status: UNSURE (   6.35  )
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

On Wed, Apr 01, 2026 at 10:52:00AM +0200, Daniel Wagner wrote:
> $ nvme config --scan --dump --output-format json /dev/nvme1

and posted the wrong example output...

nvme connect --transport tcp --traddr 192.168.30.30 --trsvcid 4420 \
        --hostnqn nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36 \
        --nqn nqn.io-1 --concat \
        --dhchap-secret=DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb: \
        --dump-config --output-format json
[
  {
    "hostnqn":"nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36",
    "hostid":"befdec4c-2234-11b2-a85c-ca77c773af36",
    "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
    "subsystems":[
      {
        "nqn":"nqn.io-1",
        "ports":[
          {
            "transport":"tcp",
            "traddr":"192.168.30.30",
            "trsvcid":"4420",
            "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
            "concat":true
          }
        ]
      }
    ]
  }
]

nvme config --scan --dump --output-format json /dev/nvme1
[
  {
    "hostnqn":"nqn.2014-08.org.nvmexpress:uuid:befdec4c-2234-11b2-a85c-ca77c773af36",
    "hostid":"befdec4c-2234-11b2-a85c-ca77c773af36",
    "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
    "subsystems":[
      {
    "subsystems":[
      {
        "nqn":"nqn.io-1",
        "ports":[
          {
            "transport":"tcp",
            "traddr":"192.168.30.30",
            "trsvcid":"4420",
            "dhchap_key":"DHHC-1:01:1+pb0VSbn3cBrOhwP5SHa6gwlbPikdZ0mmBKKXC74Sm0s0pb:",
            "concat":true
          }
        ]
      }
    ]
  }
]

