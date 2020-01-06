Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEDC32771
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 09:10:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA58207FD
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 09:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XGHuxbFJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3FuJlen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA58207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PVvO9+8E9wXB19yHr5F25toqiAb4gnyyBLldQtb3YkU=; b=XGHuxbFJPGkQj6
	b+GfhFwHOmWVuCEP4xSRyO2fWWTElCunWOs51wV2z6k4HrhqjgxAPXI+aFa/Dj7SsKPRLZSmGGp1c
	QZSDrPv3ZviM1gLVKdIPZr3JYXEE8GiMH1JL0jqQcjLyUfwDHSQ+QslahbjSAqhh2F7tdMCDQ06Db
	j4feYbaD45NI8XlKYQSUPlJmPBUeMPzfpeSjNw4q63o6jUPWNxk5PSsU3QbZApXBk6Qxe6uxyEaXk
	YEYUy0gYRDqrQEQ2UOb6X6ZuOWPAozJAElQ+OQnpyY39PO52R+C2IIub3vrHn8ZSJEcAIgS0ER2VS
	TRbpTIMi7OMR/Na/peKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioOOg-000722-LO; Mon, 06 Jan 2020 09:10:02 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioOOe-00070m-BY
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 09:10:01 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00699SJd164287;
 Mon, 6 Jan 2020 09:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2XXWSUP1BjpVGTmZ+2CsgK5T/L+9UoxH989PAMTTewQ=;
 b=i3FuJlenU+Q3KZxLkfH8pZDQJf17bClyQVzh/zeQOdvRQumxQtgV9ik5VCe6ybpxq1uV
 TdeESViMJivYzap1LRiYqSnjEXTN1XR2PB9ZOeEFaweUpJSBe0D3RlTlwtPWl8yBZKET
 dao+7kQaRPtNIQKEZn5CNHXnunCYciDlDBdGhailorLhnvFkVErHYo8wF1Pyd95RHyUI
 xIxoe14WLIQhnXoT69Xf7muWdTzfxF38Vdzt89cFEcOFCicXx/fVHG5rUUaKtVCJm5Tj
 zkhKQsBFujxiorynothHr+xiNR7fjt7wmPa0eHxFjGLS+rJ17eBc/O+Qser9LmpbnagT Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2xakbqdvkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2020 09:09:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00699af6020933;
 Mon, 6 Jan 2020 09:09:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2xb4unf3b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Jan 2020 09:09:53 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0069978Y000590;
 Mon, 6 Jan 2020 09:09:07 GMT
Received: from [192.168.1.14] (/114.88.246.185)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Jan 2020 01:09:07 -0800
Subject: Re: [resend v1 0/5] Add support for block disk resize notification
To: "Singh, Balbir" <sblbir@amazon.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <62ef2cd2-42a2-6117-155d-ed052a136c5c@oracle.com>
 <f260159c7c56a08711240cc6c7f69d2d5327a449.camel@amazon.com>
From: Bob Liu <bob.liu@oracle.com>
Message-ID: <77a665c6-1409-3dd0-2fde-221a00e04b3c@oracle.com>
Date: Mon, 6 Jan 2020 17:08:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f260159c7c56a08711240cc6c7f69d2d5327a449.camel@amazon.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_011000_525156_3E873996 
X-CRM114-Status: GOOD (  22.79  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "Sangaraju, Someswarudu" <ssomesh@amazon.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/6/20 4:47 PM, Singh, Balbir wrote:
> On Mon, 2020-01-06 at 13:59 +0800, Bob Liu wrote:
>> On 1/2/20 3:53 PM, Balbir Singh wrote:
>>> Allow block/genhd to notify user space about disk size changes
>>> using a new helper disk_set_capacity(), which is a wrapper on top
>>> of set_capacity(). disk_set_capacity() will only notify if
>>> the current capacity or the target capacity is not zero.
>>>
>>
>> set_capacity_and_notify() may be a more straightforward name.
>>
> 
> Yes, agreed.
> 
>>> Background:
>>>
>>> As a part of a patch to allow sending the RESIZE event on disk capacity
>>> change, Christoph (hch@lst.de) requested that the patch be made generic
>>> and the hacks for virtio block and xen block devices be removed and
>>> merged via a generic helper.
>>>
>>> This series consists of 5 changes. The first one adds the basic
>>> support for changing the size and notifying. The follow up patches
>>> are per block subsystem changes. Other block drivers can add their
>>> changes as necessary on top of this series.
>>>
>>> Testing:
>>> 1. I did some basic testing with an NVME device, by resizing it in
>>> the backend and ensured that udevd received the event.
>>>
>>> NOTE: After these changes, the notification might happen before
>>> revalidate disk, where as it occured later before.
>>>
>>
>> It's better not to change original behavior.
>> How about something like:
>>
>> +void set_capacity_and_notify(struct gendisk *disk, sector_t size, bool
>> revalidate)
>> {
>> 	sector_t capacity = get_capacity(disk);
>>
>> 	set_capacity(disk, size);
>>
>> +        if (revalidate)
>> +		revalidate_disk(disk);
> 
> Do you see a concern with the notification going out before revalidate_disk?

Not aware any, but keep the original behavior is safer especial when not must change..

> I could keep the behaviour and come up with a suitable name
> 
> revalidate_disk_and_notify() (set_capacity is a part of the revalidation
> process), or feel free to suggest a better name
> 

Feel free to add my reviewed-by next version in this series.
Reviewed-by: Bob Liu <bob.liu@oracle.com>

> Thanks,
> Balbir Singh
> 


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
