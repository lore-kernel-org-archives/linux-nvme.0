From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 16 Dec 2018 08:30:10 -0800
Subject: [PATCH v2 1/2] share nvme trace event helper functions with
 multiple nvme modules
In-Reply-To: <20181216014849.8584-1-yupeng0921@gmail.com>
References: <20181216014849.8584-1-yupeng0921@gmail.com>
Message-ID: <20181216163010.GA21285@infradead.org>

On Sat, Dec 15, 2018@05:48:48PM -0800, yupeng wrote:
> The trace.c could only be used by core.c, move it to a header file and
> then other nvme modules could also use it. This commit creates a new
> header file trace_common.h, which has all the functions of trace.c. It
> changes all functions to static functions, so any other modules could
> include it without conflict. This commit also moves some common
> functions from trace.h to trace_common.h. Because the trace events in
> trace.h are used by nvme-core only, this commit renames the trace.h to
> trace_core.h.

We could always export bits out of trace.o using EXPORT_SYMBOL_GPL,
no need to move duplicate the code.  Also as far as I can tell you
only use __assign_disk_name of the helpers, so we can move that into
a new helper.  It might make sense to just move that into
include/linux/genhd.h to make it easily available everywhere.
