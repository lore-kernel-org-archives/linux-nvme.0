From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 May 2017 11:35:16 -0400
Subject: [PATCH 2/2] nvme: Quirk APST on Intel 600P/P3100 devices
In-Reply-To: <db392f7634625bea0ede96c119b500d16ba9e9db.1495663545.git.luto@kernel.org>
References: <cover.1495663545.git.luto@kernel.org>
 <db392f7634625bea0ede96c119b500d16ba9e9db.1495663545.git.luto@kernel.org>
Message-ID: <20170530153516.GB2845@localhost.localdomain>

On Wed, May 24, 2017@03:06:31PM -0700, Andy Lutomirski wrote:
> They have known firmware bugs.  A fix is apparently in the works --
> once fixed firmware is available, someone from Intel (Hi, Keith!)
> can adjust the quirk accordingly.

Here's the latest firmware with all the known fixes:

  https://downloadcenter.intel.com/download/26491?v=t

I am not 100% sure if this fixes the issue you're quirking, but I think
it falls under the issues the link initialization and ASPM comments in
the release notes.
