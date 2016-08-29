From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 29 Aug 2016 09:41:08 -0500
Subject: [PATCH] nvme-cli/fabrics: Add nr_io_queues parameter to connect
 command
In-Reply-To: <20160826214549.GC19986@localhost.localdomain>
References: <20160826160112.495DFE08C5@smtp.ogc.us>
 <20160826214549.GC19986@localhost.localdomain>
Message-ID: <006101d20203$61185df0$234919d0$@opengridcomputing.com>

> > Added 'nr_io_queues' to 'connect' command so users can specify the number
> > of io queues to allocate.
> 
> Purely as a matter of consistency here, every other long-format option
> in this program uses dash '-' instead of underscore '_' as a multi-word
> separator. Let's stick with that. It works for 'git'. :)

Will do.
