Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E90C33C9E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:19:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDF22067D
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BnsypYq3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rGGgzy/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDF22067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0VXZkfHWxo+LdlNrSA3QrhRinXmBq936OULSoXDbA5I=; b=BnsypYq3LT9ImX
	d2IwI9gFgsWnlMVEszvOB2JfN2inklLZofozlkcdk0Hcv+24Ig0y9WEyxAUB9Gpwyfr6KKZWOJ/sS
	cLp0fNAc/3UpOas+/olEkzkwvze1RqVr4cxhYJvp5I07TWKvkvDdbWfrsU/7d3KoUiCDMbx8uTkaE
	RI6E6jD0eBmHvargXE72bUh1sNuSXTAdpjt3QYNyE6e4Eu15kR3NgZK1yhZoCLmbsrDkLoJb88MJ4
	KubCcSBy2PrszTYba0m/rMk0bsoTJw3Rcvi2PUD9HLXv5p9Yf0iCeul2J2VN4qCycC6aIz+yZ4QKe
	sZLIccuYFqmb8llu8kZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipOMW-0004s0-Rf; Thu, 09 Jan 2020 03:19:56 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipOMU-0004rT-88
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 03:19:55 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093HtVH162061;
 Thu, 9 Jan 2020 03:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=R0diF0l20GIH8mZCgztVoTZ4pCMP8qg/cHcB7vmaDyU=;
 b=rGGgzy/AqRhCkMlnMQw8A3ciY03rlGvzsjTH+ZS+8TUsp17gCntIS/5EUGKmNWkTlSo9
 QCXwxQ9r1Cu3/peZFFccM5DV/4T+PU0Cjtcc/YP9JAgey2VenbGXR3VdKiU5inNtfMGA
 rv4JtCRRyfI27nQpe28sodt0enpyB67PfW34DKRG7k7o1RSqbouX4KHneVUQEERhzufK
 Y5MASFnuMFVXmFBMiJIrluUPeaRBaPf077Oa8nZ1e92rsDLv4I+YHfqzxRbtYTFb0AzS
 FOCmgB1iaibvNzJdB2Z4OyFPmQnkCk+xrb1aNmYog3xhtHZsx6C7cWLkyofPsqxa71Eb LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2xakbqyy3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:19:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093IgeC075268;
 Thu, 9 Jan 2020 03:19:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2xdsa394mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:19:49 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0093Jmba028297;
 Thu, 9 Jan 2020 03:19:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 08 Jan 2020 19:19:48 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 11/15] nvmet: Rename nvmet_check_data_len to
 nvmet_check_transfer_len
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-13-maxg@mellanox.com>
Date: Wed, 08 Jan 2020 22:19:45 -0500
In-Reply-To: <20200106133736.123038-13-maxg@mellanox.com> (Max Gurtovoy's
 message of "Mon, 6 Jan 2020 15:37:32 +0200")
Message-ID: <yq1woa1xqni.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_191954_374887_57E783E9 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, israelr@mellanox.com, vladimirk@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> The function doesn't checks only the data length, because the transfer
> length includes also the metadata length in some cases. This is
> preparation for adding metadata (T10-PI) support.

Commit description needs a bit of grammar checking. Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
