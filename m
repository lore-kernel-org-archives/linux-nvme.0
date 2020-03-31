Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20503C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:50:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8106020BED
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="InrfQl7e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAwVpuy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8106020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=IL6wR9r+h5SoFTO2ksa0lDY6My2tIV4FLLMK7MrjJlk=; b=Inr
	fQl7ekN5W1XSBISFRyF8LCR2iDhSIzVMhr4nTcbwT+Dm93agalRCUpJgjnb5Y9NEYvKm7+6yZykfT
	VHUJrpFnYW7vnWpQYdBIEUXEf2IZOUQRu3MQcgC8cDy0xUaxJU5kPG8zf7Yecusq5oMPBME4+SW6j
	sphRWMqd/pPdfsdJ/kGWrsuS77UczW4J0kTs9Fnz5ZG3Bcdo/4KWGFJ5tN+AXvYve4YLKIjJj+kmT
	jDcJLn3YFY+ytgYXNxpIG1KCTIytISBHdIYy1NbRCTa7kEnnIVPhMz6yfWH7lZs4WRDmnvUNqDXOY
	PA2V/XdInDQBb5YqbKwb8lWlQaPICNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK5u-0004Zc-SR; Tue, 31 Mar 2020 16:50:30 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5l-0004Jr-VP
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:24 +0000
Received: by mail-wr1-x435.google.com with SMTP id j17so26823112wru.13
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=pyEAqLGcepa0s8YTcYIcEx3eGJpk9LOjItbdolq5d7I=;
 b=dAwVpuy3bBsEWrwTCPNItGZekIihKKfODZneeyE6NobvBjKU7N/K+TQHnRkfPszlDt
 q1Btrb0bl3kYvR3qXFiC8Rh8vPerWiCP3jPTkq46hD4B2UtCVBn6g/7O2n9JTRC53Dtc
 nbECu7fyw/rSK6T8NgTXUpIf9NXp39cXHaR58MGa+WGtBQp3EUNOgWh5olRMNpTjqkYd
 drX5xTqll5JdGD7MnAJcsJ1jRlU3LoImeTR4awKYXOUDgMuszhxTz53np2ZoYvbvZQcB
 aTJe+Z0kv6yV0X/0raVqZpQpq+oZu/2lD4W3DJCCEdp9A87TpkyksiJLT3GmihDDF0pA
 YoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pyEAqLGcepa0s8YTcYIcEx3eGJpk9LOjItbdolq5d7I=;
 b=cbdntfrMXDQ2ROcQx/ROyEHCeWyZnOluZ6TrHwBXA41Ny6tUHL4DtlqJqRYQxYQ7md
 FGcER5iaZmwyDILzBUGHdvvFwPpQDjHawNRq+edrk4GnCDhkZWa//DefU+GZtMq0OQET
 spcP0PUZ9zCYfXC191N2LVl530q61YkVquguSz902jl/qAKLa1X1I8v12jJSbRkar0Wq
 2+RkNLBU0fxFG7/wzYAuQd/gKjJSCqNAzAh6AIc06xrRiB+V5o2bNZ7tOuGTNcaQSk6/
 Y/9v/R96LqgswdW0GBd9rBS01DlVt/7RKRJ/Nq3ihjEGaemmsW3vTf90cvjR9GhbLhW3
 uC0Q==
X-Gm-Message-State: ANhLgQ2E/kEFj/6O48tHkc1RueSR1ACezvGezWRiR8pQDiL+OuJV2//D
 YDalfkBFpBw6CNkJNpJiGRQva4d6
X-Google-Smtp-Source: ADFU+vtbWg364JXSbftT2KC+gIY0wO0Qq00B0hpNtH+VYoj3ygqGgmB2gO/8fhiGgRMv4CVqxey7nQ==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr23251057wrq.347.1585673417729; 
 Tue, 31 Mar 2020 09:50:17 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:17 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 00/26] nvme-fc/nvmet-fc: Add FC-NVME-2 disconnect
 association support
Date: Tue, 31 Mar 2020 09:49:45 -0700
Message-Id: <20200331165011.15819-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095022_037744_098A6CB8 
X-CRM114-Status: GOOD (  22.86  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

At the tail end of FC-NVME (1) standardization, the process for
terminating an association was changed requiring interlock using FC-NVME
Disconnect Assocation LS's between both the host port and target port.
This was immediately relaxed with an ammendment to FC-NVME (1) and with
wording put into FC-NVME-2. The interlock was removed, but it still
required both the host port and target port to initiate Disconnect
Association LS's and respond to LS's.

The linux nvme-fc and nvmet-fc implementations were interoperable with
standards but the linux-driver api did not support all the functionality
needed. It was missing:
- nvme-fc: didn't support the reception of NVME LS's and the ability to
  transmit responses to an LS.
- nvmet-fc: didn't support the ability to send an NVME LS request. It
  also did not support a method for the transport to specify a remote
  port for an LS.

This patch adds the missing functionality. Specifically the patch set:
- Updates the header with the FC-NVME-2 standard out for final approval.
- Refactors data structure names that used to be dependent on role (ls
  requests were specific to nvme; ls responses were specific to nvmet)
  to generic names that can be used by both nvme-fc and nvmet-fc.
- Modifies the nvme-fc transport template with interfaces to receive
  NVME LS's and for the transport to then request LS responses to be
  sent.
- Modifies the nvmet-fc transport template with:
  - The current NVME LS receive interface was modified to supply a
    handle to indentify the remote port the LS as received from. If
    the LS creates an association, the handle may be used to initiate
    NVME LS requests to the remote port. An interface was put in place
    to invalidate the handle on connectivity losses.
  - Interfaces for the transport to request an NVME LS request to be
    performed as well as to abort that LS in cases of error/teardown. 
- The nvme-fc transport was modified to follow the standard:
  - Disconnect association logic was revised to send Disconnect LS as
    soon as all ABTS's were transmit rather than waiting for the ABTS
    process to fully complete.
  - Disconnect LS reception is supported, with reception initiating
    controller reset and reconnect.
  - Disconnect LS responses will not be transmit until association
    termination has transmit the Disconnect LS.
- The nvmet-fc transport was modified to follow the standard:
  - Disconnect assocation logic was revised to transmit a Disconnect LS
    request as soon as all ABTS's have been transmit. In the past, no
    Disconnect LS had been transmit.
  - Disconnect LS responses will not be sent until the Disconnect LS
    request has been transmit.
- nvme-fcloop: was updated with interfaces to allow testing of the
  transports.
- Along the way, cleanups and slight corrections were made to the
  transports.
- The lpfc driver was modified to support the new transport interfaces
  for both the nvme and nvmet transports.  As much of the functionality
  was already present, but specific to one side of the transport,
  existing code was refactored to create common routines. Addition of
  the new interfaces was able to slip in rather easily with the common
  routines.

This code was cut against the for-5.7 branch.

I'll work with Martin to minimize any work to merge these lpfc mods 
with lpfc changes in the scsi tree.

V2 changes:
  Split out 2 fixes into patches sent separately
    a typo & fcloop deallocation of context
  Patches slightly reordered
  Include fix to Connection disconnect LS spotted by Hannes (patch1)
  Combined header/nvme-fc/nvmet-fc/lpfc sync to api name change into
    1 patch (patch2)
  Convert assoc_active patch converted to use test_and_set/clear.
    Converted other flag field to use same bit routines.  (patch 6)
  Split common definitions patch into host and target patches
    (patches 8 & 9)
  Remove unused local variable writedataactive (patch 11)
  Replaced c++ style comment (patch 14)
  Moved location of lsdir field (patch 15)
  Removed atomic stats from lpfc that aren't necessary
    (patches 24 & 26)
  Add reviewed by's from Sagi, Hannes, Himanshu


-- james



James Smart (26):
  nvme-fc: Sync header to FC-NVME-2 rev 1.08
  nvme-fc and nvmet-fc: revise LLDD api for LS reception and LS request
  nvme-fc nvmet-fc: refactor for common LS definitions
  nvmet-fc: Better size LS buffers
  nvme-fc: Ensure private pointers are NULL if no data
  nvme-fc: convert assoc_active flag to bit op
  nvme-fc: Update header and host for common definitions for LS handling
  nvmet-fc: Update target for common definitions for LS handling
  nvme-fc: Add Disconnect Association Rcv support
  nvmet-fc: add LS failure messages
  nvmet-fc: perform small cleanups on unneeded checks
  nvmet-fc: track hostport handle for associations
  nvmet-fc: rename ls_list to ls_rcv_list
  nvmet-fc: Add Disconnect Association Xmt support
  nvme-fcloop: refactor to enable target to host LS
  nvme-fcloop: add target to host LS request support
  lpfc: Refactor lpfc nvme headers
  lpfc: Refactor nvmet_rcv_ctx to create lpfc_async_xchg_ctx
  lpfc: Commonize lpfc_async_xchg_ctx state and flag definitions
  lpfc: Refactor NVME LS receive handling
  lpfc: Refactor Send LS Request support
  lpfc: Refactor Send LS Abort support
  lpfc: Refactor Send LS Response support
  lpfc: nvme: Add Receive LS Request and Send LS Response support to
    nvme
  lpfc: nvmet: Add support for NVME LS request hosthandle
  lpfc: nvmet: Add Send LS Request and Abort LS Request support

 drivers/nvme/host/fc.c             | 569 ++++++++++++++++++++------
 drivers/nvme/host/fc.h             | 227 +++++++++++
 drivers/nvme/target/fc.c           | 798 ++++++++++++++++++++++++++----------
 drivers/nvme/target/fcloop.c       | 155 ++++++-
 drivers/scsi/lpfc/lpfc.h           |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c      |   3 -
 drivers/scsi/lpfc/lpfc_crtn.h      |   9 +-
 drivers/scsi/lpfc/lpfc_ct.c        |   1 -
 drivers/scsi/lpfc/lpfc_debugfs.c   |   5 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c   |   8 +-
 drivers/scsi/lpfc/lpfc_init.c      |   7 +-
 drivers/scsi/lpfc/lpfc_mem.c       |   4 -
 drivers/scsi/lpfc/lpfc_nportdisc.c |  13 +-
 drivers/scsi/lpfc/lpfc_nvme.c      | 491 ++++++++++++++--------
 drivers/scsi/lpfc/lpfc_nvme.h      | 181 +++++++++
 drivers/scsi/lpfc/lpfc_nvmet.c     | 804 ++++++++++++++++++++++---------------
 drivers/scsi/lpfc/lpfc_nvmet.h     | 158 --------
 drivers/scsi/lpfc/lpfc_sli.c       | 126 +++++-
 include/linux/nvme-fc-driver.h     | 368 ++++++++++++-----
 include/linux/nvme-fc.h            |  11 +-
 20 files changed, 2808 insertions(+), 1132 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h
 delete mode 100644 drivers/scsi/lpfc/lpfc_nvmet.h

-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
