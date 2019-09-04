Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5157C3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:16:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7630321883
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxGLK5bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7630321883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RSVzY/JLTIzIQAphq3fsxTMVzO/Han7DZFkt2JLqL2o=; b=SxGLK5bOaBhhNa
	q/78HDlCmLMxNRIEtfEhohXN4ldeLLsdOIIELWRpioEX1I40qftvMUhrET9rQE/G+kg7ctlW3dpx3
	e5qBEgRxcVDVg77HOekyIIG2D3MWlWpGCwexTDwE4HQbjczTMbG37yGhNmmtIj61EjGbDCtzzhXr2
	yjOhdzlSSb9/lcZ0ttCrrIzlqRnGvkVgCIF90r5Hxh8Ej1byzFsmmIqtldYYNycmLNydaoCp7yK+p
	/4N9WNIvlTU4c4JAFG53YDx+L+Kru5NbxBwKgZ2GhkgAIsQR1jtC3DcCcowdjMUJKVE7O+kXnLzj3
	aE5+k04chqzkRt6uQiGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5YtR-0003CO-19; Wed, 04 Sep 2019 17:16:29 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5YtF-0002zk-MR
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 17:16:19 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 10:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; d="scan'208";a="212470355"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2019 10:16:16 -0700
Date: Wed, 4 Sep 2019 11:14:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190904171445.GG21302@localhost.localdomain>
References: <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
 <20190904163557.GF21302@localhost.localdomain>
 <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_101617_743108_AF18E554 
X-CRM114-Status: GOOD (  10.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 11:01:22AM -0600, Logan Gunthorpe wrote:
> Oh, yes that's simpler than the struct/kref method and looks like it
> will accomplish the same thing. I did some brief testing with it and it
> seems to work for me (though I don't have any subsystems with multiple
> controllers). If you want to make a patch out of it you can add my
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks! I'll make it a proper patch and send shortly.

For testing multi-controller subsystems, I haven't got proper hardware
either, so I really like the nvme loop target. Here's a very simple json
defining a two namespace subsystem backed by two real nvme devices:

loop.json:
---
{
  "ports": [
    {
      "addr": {
        "adrfam": "",
        "traddr": "",
        "treq": "not specified",
        "trsvcid": "",
        "trtype": "loop"
      },
      "portid": 1,
      "referrals": [],
      "subsystems": [
        "testnqn"
      ]
    }
  ],
  "subsystems": [
    {
      "attr": {
        "allow_any_host": "1"
      },
      "namespaces": [
        {
          "device": {
            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a8",
            "path": "/dev/nvme0n1"
          },
          "enable": 1,
          "nsid": 1
        },
        {
          "device": {
            "nguid": "ef90689c-6c46-d44c-89c1-4067801309a9",
            "path": "/dev/nvme1n1"
          },
          "enable": 1,
          "nsid": 2
        }
      ],
      "nqn": "testnqn"
    }
  ]
}
--

Configure the target:

  # nvmetcli restore loop.json

Connect to it twice:

  # nvme connect -n testnqn -t loop
  # nvme connect -n testnqn -t loop

List the result:

  # nvme list -v
  NVM Express Subsystems

  Subsystem        Subsystem-NQN                                                                                    Controllers
  ---------------- ------------------------------------------------------------------------------------------------ ----------------
  nvme-subsys0     nqn.2014.08.org.nvmexpress:8086108ePHLE7200015N6P4BGN-17335943:ICDPC5ED2ORA6.4T                  nvme0
  nvme-subsys1     nqn.2014.08.org.nvmexpress:8086108ePHLE7200015N6P4BGN-27335943:ICDPC5ED2ORA6.4T                  nvme1
  nvme-subsys2     testnqn                                                                                          nvme2, nvme3

  NVM Express Controllers

  Device   SN                   MN                                       FR       TxPort Address        Subsystem    Namespaces
  -------- -------------------- ---------------------------------------- -------- ------ -------------- ------------ ----------------
  nvme0    PHLE7200015N6P4BGN-1 7335943:ICDPC5ED2ORA6.4T                 QDV1RD07 pcie   0000:88:00.0   nvme-subsys0 nvme0n1
  nvme1    PHLE7200015N6P4BGN-2 7335943:ICDPC5ED2ORA6.4T                 QDV1RD03 pcie   0000:89:00.0   nvme-subsys1 nvme1n1
  nvme2    9eb72cbeecc6fdb0     Linux                                    5.3.0-rc loop                  nvme-subsys2 nvme2n1, nvme2n2
  nvme3    9eb72cbeecc6fdb0     Linux                                    5.3.0-rc loop                  nvme-subsys2 nvme2n1, nvme2n2

  NVM Express Namespaces

  Device       NSID     Usage                      Format           Controllers
  ------------ -------- -------------------------- ---------------- ----------------
  nvme0n1      1          3.20  TB /   3.20  TB    512   B +  0 B   nvme0
  nvme1n1      1          3.20  TB /   3.20  TB    512   B +  0 B   nvme1
  nvme2n1      1          3.20  TB /   3.20  TB    512   B +  0 B   nvme2, nvme3
  nvme2n2      2          3.20  TB /   3.20  TB    512   B +  0 B   nvme2, nvme3



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
