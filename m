Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBEC6369E
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 21:04:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6CF206CA
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 21:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6CF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OZwr+YfgE1nMXqfMXfFRZGp+W55J77YGAfu3KqqbAfM=; b=xuTsC09hyq/Eg+0S1nlblbW/02
	JhniCUTHwJ3aQkmgwQCbGG8edW9oTxMLh6tS6Xlvcx5z53QxKCUMG2KzBrCO2nvYXb0uazZym8+9v
	4l0AS4EBvQjUFH39JHQX5jHqsVMEr+RUrUkjkxDzOjG9MuEUhJlVArMfkSrtgAQEEQ4Ejjmy1YVmj
	8QchecHjQCMbRQ3wXZq8nJLq1l70JxlZcRzBVOjW5ajKi3OuPeu6q+qomvJV7ylCAyhGh9+AxnTSb
	wuqTbpJ4jggis3fGjha3+NJHJvRWxzkfKUc3TqYUHVdOjtPCyrx5FJcxSiKwNMV2Phvcj2fMVDJK9
	uAfKlHtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkZIh-0003dS-No; Wed, 02 Dec 2020 21:04:35 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkZII-0003RE-83
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 21:04:28 +0000
IronPort-SDR: qUNgsmksYoeEPdDmSnzajSoArSvwnoYNClKXIFpgaT61EZ5gm1R0w524eP49C7cMaLF6IijtJJ
 SBSzHMp4JmpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257798994"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="257798994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2020 13:04:06 -0800
IronPort-SDR: UzQF4FG9s+hHIssHliDgQBJAuk2LyNP+JDBa6qE9tshFcqUqaGzlu1Nmtw4ak23Vk97OQ82qUS
 flZH+J6u/O8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; d="scan'208";a="368149154"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
 by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2020 13:04:05 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kkZID-0000L3-0j; Wed, 02 Dec 2020 21:04:05 +0000
Date: Thu, 3 Dec 2020 05:03:21 +0800
From: kernel test robot <lkp@intel.com>
To: James Smart <james.smart@broadcom.com>
Subject: [linux-nvme:nvme-5.11 1/23] drivers/nvme/target/fcloop.c:1506:6:
 warning: %x in format string (no. 1) requires 'unsigned int but the argument
 type is 'signed int
Message-ID: <202012030517.jxsC8lFW-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_160410_510637_00987796 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: kbuild-all@lists.01.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

tree:   git://git.infradead.org/nvme.git nvme-5.11
head:   2f4c9ba23b887e7a69a474e9d53f38b5833a2119
commit: 03d99e5d63dabe2c0cea0d8fe1cb89bde33f7939 [1/23] nvme-fcloop: add sysfs attribute to inject command drop
compiler: c6x-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> drivers/nvme/target/fcloop.c:1506:6: warning: %x in format string (no. 1) requires 'unsigned int *' but the argument type is 'signed int *'. [invalidScanfArgType_int]
    if (sscanf(buf, "%x:%d:%d", &opcode, &starting, &amount) != 3)
        ^
   drivers/nvme/target/fcloop.c:1632:32: warning: Uninitialized variable: lport [uninitvar]
     ret = __wait_localport_unreg(lport);
                                  ^
   drivers/nvme/target/fcloop.c:1615:28: warning: Uninitialized variable: nport [uninitvar]
     ret = __remoteport_unreg(nport, rport);
                              ^

vim +1506 drivers/nvme/target/fcloop.c

  1499	
  1500	static ssize_t
  1501	fcloop_set_cmd_drop(struct device *dev, struct device_attribute *attr,
  1502			const char *buf, size_t count)
  1503	{
  1504		int opcode, starting, amount;
  1505	
> 1506		if (sscanf(buf, "%x:%d:%d", &opcode, &starting, &amount) != 3)
  1507			return -EBADRQC;
  1508	
  1509		drop_current_cnt = 0;
  1510		drop_fabric_opcode = (opcode & ~DROP_OPCODE_MASK) ? true : false;
  1511		drop_opcode = (opcode & DROP_OPCODE_MASK);
  1512		drop_instance = starting;
  1513		/* the check to drop routine uses instance + count to know when
  1514		 * to end. Thus, if dropping 1 instance, count should be 0.
  1515		 * so subtract 1 from the count.
  1516		 */
  1517		drop_amount = amount - 1;
  1518	
  1519		pr_info("%s: DROP: Starting at instance %d of%s opcode x%x drop +%d "
  1520			"instances\n",
  1521			__func__, drop_instance, drop_fabric_opcode ? " fabric" : "",
  1522			drop_opcode, drop_amount);
  1523	
  1524		return count;
  1525	}
  1526	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
