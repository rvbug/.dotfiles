# Setting PATH for Python 3.9
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rakesh.venkat/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/rakesh.venkat/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rakesh.venkat/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rakesh.venkat/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### for pipenv
export PATH="$PATH:/Users/rakesh.venkat/.local/bin"


### For Hadoop
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.0.1.jdk/Contents/Home
export HADOOP_HOME=/Users/rakesh.venkat/Documents/rakesh/hadoop-2.7.2
export PATH=JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH
export PATH=/Library/Java/JavaVirtualMachines/jdk-17.0.1.jdk/Contents/Home/bin:/Users/rakesh.venkat/Documents/rakesh/hadoop-2.7.2/bin:/Users/rakesh.venkat/opt/miniconda3/bin:/Users/rakesh.venkat/opt/miniconda3/condabin:/Library/Frameworks/Python.framework/Versions/3.9/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/rakesh.venkat/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:$PATH
echo "Welcome!!"
. "$HOME/.cargo/env"
