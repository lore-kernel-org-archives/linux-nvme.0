From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 25 Jan 2018 15:48:42 -0700
Subject: Reconnect on RDMA device reset
In-Reply-To: <1516904022.27592.187.camel@redhat.com>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
Message-ID: <20180125224842.GB11537@ziepe.ca>

On Thu, Jan 25, 2018@01:13:42PM -0500, Doug Ledford wrote:

> various events.  That might have changed...didn't we just take a patch
> to rdma-core to drop the shell script?  It might not reconnect
> automatically with the latest rdma-core, I'd have to check.  Bart should
> know though...

We dropped the shell script in favor of udev. srp_daemon will now
stop when rdma devices are removed and restart again when they are
added.

Jason
