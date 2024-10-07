Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481A4CFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz7K1WbIZvukbVeRCC4cp4pbcDaxoP8Djj5+aa4ZYpo=; b=R+L0M1wlJri6wwRG8IVkb2boVY
	WiDGVH/zcbkWtYsoQi/QbQQBQtuxikx62z92Hb9pGOXMycj27BQyxZfzOtQQTWeZGAJQyJqSTCYQ6
	DHZ5L4yNbQtQl13ueM88t5TiIO2tADNNl4Ich846ASpDNHMlKCom5daizplEwWiuDO5BohSX5bkgT
	364Wr0uCuI3288s1LHJj4ZP15nkgQgL1EvnrT/Rsq7uB42q5BYBmEeHZF6JvJILSy3o4kpIcwC01R
	CfMURqJnO5HOc+bjYWPgZ00gsfBAMbhhAuLzBRQpX42+5QbMidcGBd0FrHmpu1GQTN5i//CskbNN0
	9WpeeYRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxizg-00000001k0D-44NU;
	Mon, 07 Oct 2024 08:21:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxibD-00000001g94-0lJ2
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 07:56:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4977mbTM018997;
	Mon, 7 Oct 2024 07:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=g
	z7K1WbIZvukbVeRCC4cp4pbcDaxoP8Djj5+aa4ZYpo=; b=UXPiipIzsZR2trNoH
	Epi+4GhWm40nrnJs3syCU2bL774DMQM/ehYS2NhGw32qlDEzURUR/uuvVGTwgvyg
	X4cXdh4fBAcmbqKp8WtfeZwafs+0kLgBg3qTZy2xrorr8BbekRn53ltYxI9jxb+O
	RvF63NLWbLHp5nmSa6vL80srSgvaHyVYWW9Bf2Mrxv38DuxJCDWsi9SqQl04AjK5
	QOqNGcgdnIjzYNIs9+0McSZ9YiijpHpk3DSqzXqoWnnvSoTtUW+MtcoAPcicKLYU
	B2kAv1hU7PG2D+k+Ljz5K5+zZLHWmK0mXsWdADWBLBi/pm0raQziRYJ/3ispwMkh
	TD9dg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424bje010u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 07:56:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4975JVtG022861;
	Mon, 7 Oct 2024 07:56:00 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0mwh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Oct 2024 07:56:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4977txJG21037586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Oct 2024 07:56:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E6EF58068;
	Mon,  7 Oct 2024 07:55:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9088958052;
	Mon,  7 Oct 2024 07:55:57 +0000 (GMT)
Received: from [9.179.23.72] (unknown [9.179.23.72])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Oct 2024 07:55:57 +0000 (GMT)
Message-ID: <5cfe49e2-0d78-4e16-b8a7-bc3fda90c2e5@linux.ibm.com>
Date: Mon, 7 Oct 2024 13:25:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: make keep-alive synchronous operation
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20241004114711.780809-1-nilay@linux.ibm.com>
 <20241004114711.780809-3-nilay@linux.ibm.com> <20241007064149.GB1141@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241007064149.GB1141@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K3UuPI6GjwjN_dm4RmzwvapaSyehmWNu
X-Proofpoint-ORIG-GUID: K3UuPI6GjwjN_dm4RmzwvapaSyehmWNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_21,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=784
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_005611_494292_91292337 
X-CRM114-Status: GOOD (  22.44  )
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



On 10/7/24 12:11, Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 05:16:57PM +0530, Nilay Shroff wrote:
>> The nvme keep-alive operation, which executes at a periodic interval,
>> could potentially sneak in while shutting down a fabric controller.
>> This may lead to a race between the fabric controller admin queue
>> destroy code path (while shutting down controller) and the blk-mq
>> hw/hctx queuing from the keep-alive thread.
>>
>> This fix helps avoid race by implementing keep-alive as a synchronous
>> operation so that admin queue-usage ref counter is decremented only
>> after keep-alive command finish execution and returns its status.
> 
> With that you mean ->q_usage_counter?
Yes I meant ->q_usage_counter.
> 
> Moving to synchronous submission and wasting a workqueue context for
> that is a bit sad.  I think just removing the blk_mq_free_request call
> from nvme_keep_alive_finish and returning RQ_END_IO_FREE instead
> should have the same effect, or am I missing something?
> 
Unfortunately, that would not help because we still fall through the same 
code path and here we're just moving blk_mq_free_request call from 
nvme_keep_alive_finish to its caller. For instance, assuming we keep 
nvme_keep_alive work asynchronous then the code path for invoking 
nvme_keep_alive_finish would be,

nvme_keep_alive_work()
  ->blk_execute_rq_no_wait()
    ->blk_mq_run_hw_queue()
      ->blk_mq_sched_dispatch_requests()
        ->__blk_mq_sched_dispatch_requests()
          ->blk_mq_dispatch_rq_list()
            ->nvme_loop_queue_rq()
              ->nvme_fail_nonready_command() 
                ->nvme_complete_rq()
                  ->nvme_end_req()
                    ->blk_mq_end_request()
                      ->__blk_mq_end_request()
                        ->nvme_keep_alive_finish() 

In the above call path, if nvme_keep_alive_finish returns RQ_END_IO_FREE (and we 
remove blk_mq_free_request call from it) then the caller __blk_mq_end_request would 
then invoke blk_mq_free_request and we may still hit the same bug because 
this would allow blk_mq_destroy_queue() (which may be running on another cpu from 
the controller shutdown code path) forward progress and next from blk_put_queue()
the admin queue resources are deleted.

>> Also, while we are at it, instead of first acquiring ctrl lock and then
>> accessing NVMe controller state, lets use the helper function
>> nvme_ctrl_state() in nvme_keep_alive_end_io() and get rid of the
>> lock.
> 
> Please split that into a separate patch.
Sure I would split the patch and resend the series. 

And thank you for your review comments!

--Nilay

