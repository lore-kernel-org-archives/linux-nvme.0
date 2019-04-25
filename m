From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Apr 2019 09:57:00 +0900
Subject: [PATCH 1/2] nvme: pci: Return -EINVAL if given nr_queue larger
 than nr_cpu
In-Reply-To: <f01517db-74ba-477f-49fe-88aaf0b8ab89@grimberg.me>
References: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
 <20190411155239.1094-2-minwoo.im.dev@gmail.com>
 <f01517db-74ba-477f-49fe-88aaf0b8ab89@grimberg.me>
Message-ID: <6e1be82f-2fac-519a-8582-ee66387c6d3e@gmail.com>


 >>>> "write_queues" and "poll_queues" can be configured by module 
parameters
 >>>> with callback queue_count_set().
 >>>>
 >>>> This function shall return a error if given number of queue is larger
 >>>> than nr_possible_cpus due to blk-mq.
 >>>
 >>> Why?
 >>
 >> I think I missed to write the details about what you asked for.  The
 >> reason is that
 >> now the variable n seems to be assigned without being used after all.
 >>
 >> I'm not sure whether it needs to return error or go through with
 >> reduced value for
 >> queue_cnt which is not greater than num_possible_cpus().
 >>
 >> If you would let me know what's going to be better for this, that
 >> would be great.
 >
 > I think its consistent with the rest of the fabric implementations..

Hi Sagi,

Do you mean that it needs to be reduced if value which is greater than 
num_possible_cpus() is given instead returning an error ?

Thanks,
