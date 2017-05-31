From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 31 May 2017 06:54:51 -0700
Subject: [PATCH 2/2] nvme: Quirk APST on Intel 600P/P3100 devices
In-Reply-To: <20170530153516.GB2845@localhost.localdomain>
References: <cover.1495663545.git.luto@kernel.org>
 <db392f7634625bea0ede96c119b500d16ba9e9db.1495663545.git.luto@kernel.org>
 <20170530153516.GB2845@localhost.localdomain>
Message-ID: <CALCETrVa4xvAKyw=-dwRpOExwFrKuVdmMDixaCjaWV0HYtuO5A@mail.gmail.com>

On Tue, May 30, 2017@8:35 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, May 24, 2017@03:06:31PM -0700, Andy Lutomirski wrote:
>> They have known firmware bugs.  A fix is apparently in the works --
>> once fixed firmware is available, someone from Intel (Hi, Keith!)
>> can adjust the quirk accordingly.
>
> Here's the latest firmware with all the known fixes:
>
>   https://downloadcenter.intel.com/download/26491?v=t
>
> I am not 100% sure if this fixes the issue you're quirking, but I think
> it falls under the issues the link initialization and ASPM comments in
> the release notes.

Can you or someone at Intel supply a reliable way to distinguish a
fixed firmware from an unfixed firmware?  We have access to the "fr"
string, but I don't know what to do with it.
