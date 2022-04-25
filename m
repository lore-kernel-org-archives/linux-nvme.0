Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CBFC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X1ZxMF5hfhykYhyHeWc0h7VbH/rjujMJazMMlxmiG4Q=; b=p6nuEJAySLqiRo6d1lIQ+IPgbj
	3JlCAxSIncxQxDy4XyyNy2cVQM1pylkOV9Gqy7NRVkfAakauSNXuHCJMEDtQdV5Oyu7sE9d8qM6uq
	Zf13+JhP4U90bIPOev3YKtvrdOSM2rEgV54Oh+RQGmb5Jo8LzVYxlpli5vZS6DetymGZ56zHgw3xA
	vcj6i5GXXy8EBM5HDjL1Zg2Joj6M7qrTXEPaveti/B6E1XmgcmSg/hilwf7knvSiyeqdggeQiNJYo
	bXBQBZ+azNcKHknPeg5khou2aTg85xxVD906wjxEJrLdNjEEkccQkKY2YhJOwaI+E/3eBEHzcHk3E
	j20MnoSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3PQ-00Aqfe-9M; Mon, 25 Apr 2022 18:26:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PD-00AqZ2-6H
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:25:53 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP7QP005334
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=X1ZxMF5hfhykYhyHeWc0h7VbH/rjujMJazMMlxmiG4Q=;
 b=FsVAb7VGy975Loj7JBQHiH6K9tPVJe5jjnzt0fHQnUbpSICq/JcKadj8IKn5+4WvI3XV
 45Qtuc0F2dFuGm7P+GEY/vwrtddQzrHBKSgD2rNnHFVx0glJV1IvjaNbN7DbvyTr/p9q
 Sx83LD4uUu17eDx75RcG2PpZcBmLYcDK/cc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmf9puxv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:50 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:25:49 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 194EDE1F2A53; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v3 00/12] add large CQE support for io-uring
Date: Mon, 25 Apr 2022 11:25:18 -0700
Message-ID: <20220425182530.2442911-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CHA79RJF0URBB9N0OoIuOIGNtOYnUKD5
X-Proofpoint-GUID: CHA79RJF0URBB9N0OoIuOIGNtOYnUKD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112551_427544_A33475C7 
X-CRM114-Status: GOOD (  23.64  )
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

This adds the large CQE support for io-uring. Large CQE's are 16 bytes lo=
nger.
To support the longer CQE's the allocation part is changed and when the C=
QE is
accessed.

The allocation of the large CQE's is twice as big, so the allocation size=
 is
doubled. The ring size calculation needs to take this into account.

All accesses to the large CQE's need to be shifted by 1 to take the bigge=
r size
of each CQE into account. The existing index manipulation does not need t=
o be
changed and can stay the same.

The setup and the completion processing needs to take the new fields into
account and initialize them. For the completion processing these fields n=
eed
to be passed through.

The flush completion processing needs to fill the additional CQE32 fields=
.

The code for overflows needs to be adapted accordingly: the allocation ne=
eds to
take large CQE's into account. This means that the order of the fields in=
 the io
overflow structure needs to be changed and the allocation needs to be enl=
arged
for big CQE's.
In addition the two new fields need to be copied for large CQE's.

The new fields are added to the tracing statements, so the extra1 and ext=
ra2
fields are exposed in tracing. The new fields are also exposed in the /pr=
oc
filesystem entry.

For testing purposes the extra1 and extra2 fields are used by the nop ope=
ration.


Testing:

The exisiting tests have been run with the following configurations and t=
hey all
pass:

- Default config
- Large SQE
- Large CQE
- Large SQE and large CQE.

In addition a new test has been added to liburing to verify that extra1 a=
nd extra2
are set as expected for the nop operation.

Note:
To use this patch also the corresponding changes to the client library
liburing are required. A different patch series is sent out for this.


Changes:
  V2: - added support for CQE32 in the /proc filesystem entry output func=
tion
      - the definition of the io_uring_cqe_extra field has been changed
        to avoid warning with the /proc changes.
  V3: - use __64 for big cqe in io_uring_cqe data structure
      - use io_req_complete_state helper in __io_req_complete32
      - support cached cqe's
      - use bool for cqe32 check in io_cqring_event_overflow
      - use bool for cqe32 check in __io_uring_show_fdinfo


Stefan Roesch (12):
  io_uring: support CQE32 in io_uring_cqe
  io_uring: wire up inline completion path for CQE32
  io_uring: change ring size calculation for CQE32
  io_uring: add CQE32 setup processing
  io_uring: add CQE32 completion processing
  io_uring: modify io_get_cqe for CQE32
  io_uring: flush completions for CQE32
  io_uring: overflow processing for CQE32
  io_uring: add tracing for additional CQE32 fields
  io_uring: support CQE32 in /proc info
  io_uring: enable CQE32
  io_uring: support CQE32 for nop operation

 fs/io_uring.c                   | 234 ++++++++++++++++++++++++++++----
 include/trace/events/io_uring.h |  18 ++-
 include/uapi/linux/io_uring.h   |   7 +
 3 files changed, 225 insertions(+), 34 deletions(-)


base-commit: fd1cf8f1947eb7b009eb79807ec8af0e920fc57b
--=20
2.30.2


