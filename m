From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Jan 2019 07:55:39 -0700
Subject: Question about ioctl interface - IO passthru
In-Reply-To: <CAPrnrPBpcuh2r40Bxzrq=PmDAaemnOvd4Or2nKFCannQ6oGkGg@mail.gmail.com>
References: <CAPrnrPBpcuh2r40Bxzrq=PmDAaemnOvd4Or2nKFCannQ6oGkGg@mail.gmail.com>
Message-ID: <20190131145539.GB19637@localhost.localdomain>

On Thu, Jan 31, 2019@04:09:18PM +0200, Eyal BenDavid wrote:
> What is the difference from using "nvme_user_io" structure?
> Is it safe to use this version of IO commands?

The passthru structure is good to use for any command. The
nvme_user_io structure is a legacy feature from very early nvme days
when read/write/compare were the only IO commands. It didn't extend to
other IO commands, and deprecating it wouldn't be a bad thing.
